import config from "@workspace/app-config";
import { supabase } from "@workspace/supabase-config";
import { Button } from "@workspace/ui/components/button";
import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@workspace/ui/components/card";

export default async function Page() {
  let { data: tenant_profiles, error } = await supabase
    .from("tenant_profiles")
    .select("*")
    .eq("id", "fa732f4c-c906-4e5c-8f8b-c874e6968f86");
  return (
    <div className="w-full h-screen flex justify-center items-center">
      <div className="w-2xl h-xl">
        <Card>
          <CardHeader>
            <CardTitle>{config.app.name}</CardTitle>
            <CardDescription>
              {tenant_profiles![0]?.display_name}
            </CardDescription>
            <CardAction>{`https://${tenant_profiles![0]?.subdomain}.our-app.com`}</CardAction>
          </CardHeader>
          <CardContent>
            <p>{config.app.description}</p>
          </CardContent>
          <CardFooter>
            <p>Card Footer</p>
          </CardFooter>
        </Card>
      </div>
    </div>
  );
}
