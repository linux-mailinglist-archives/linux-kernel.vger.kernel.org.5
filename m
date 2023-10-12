Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37E47C6545
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbjJLGSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbjJLGSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:18:02 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7EFE0;
        Wed, 11 Oct 2023 23:18:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77412b91c41so40393385a.1;
        Wed, 11 Oct 2023 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697091480; x=1697696280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3I0koB03A5MU4SvfC6Xri7NpEuR71oDrHo8h3uQuHc=;
        b=aEn7eB7YvGET3MLrOFHQvUfLagKZUPgDUTmQDKr4XVJW45nFjQ3BnW7oUb3lQvQYfh
         w0Rvo8dynm4XVasfzfVUO3YjwH6XWuUYVk641svS9B6tG2snEYCbdKDl72D+U0Y7zfqh
         EYHRdFhAdL3iVafEC/g99g8Iu7vew9NW54butrMtdVZ84YSJgjeL/TiARckHsIEMfu18
         RorrqbND4jb6lW/21aWYSMWJgjTJ3S8H3OCSn3EzbBpzlp0HVF49OtwZvJBFOAVclSut
         Dc4VNygYcYQ5z5fEOh59LTsnb7MvALgy7oigBjng+rMJQ9cviDqrcZqBCAoT6tH0F3li
         4XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091480; x=1697696280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3I0koB03A5MU4SvfC6Xri7NpEuR71oDrHo8h3uQuHc=;
        b=R0g6DXq5zh3m7ncx/5qw/Eu5A+JTivXvT4oDHOvWtY8FhudDrLtfkLmSfXKBl6RE83
         Cz/rNzpaQeWp4kTcISIe0VrjkOTSIXDy9K8CVY1mYOGT/XNKZ1U4CH1FwtG6Ed75NZOh
         QdpgFyKQVrtWMf95J6RdZqJiXb01UsQx4199S0tRw7DSOvfer4PnjMabyziYHZQwQrXv
         owWSirQBQus5eLkSniizkLeABv+SFVnd0BrJqqZdE4U4gfwmdfSzMGBN9cHCpiXrH5Ls
         9pq0FyQAchyec2DMBMu1i2/PMGZhXiWsANyxyF/Bi8LaHvaH7vMhOlnqtT4xI795FFuA
         JugQ==
X-Gm-Message-State: AOJu0YzdZscH3nV2nZfqfoQJCrM5o4EnVrAV3wEEZQENP7eSdslewUHc
        acEBMeCNdBJiKFxXypoWPqHbpMS9Z+aVI4VWDXU=
X-Google-Smtp-Source: AGHT+IEWKmOH+H7lmwNCPhfhlRARsLQyCJVlONxn0dj2YgwX1dMFQ6s8cqmjcGc7R5oMExKiASkK7l2rqO4mp2q1o7Q=
X-Received: by 2002:ad4:4450:0:b0:65d:56c:5177 with SMTP id
 l16-20020ad44450000000b0065d056c5177mr21575288qvt.57.1697091479590; Wed, 11
 Oct 2023 23:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231012043501.9610-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231012043501.9610-1-m.muzzammilashraf@gmail.com>
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date:   Thu, 12 Oct 2023 11:17:48 +0500
Message-ID: <CAJHePoZ+J1CpEhkT-93jicFvSEPkSofmtt5kqenrwdBYoOm=9g@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
To:     horms@kernel.org, loic.poulain@linaro.org, ryazanov.s.a@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cb1c7606077ee616"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cb1c7606077ee616
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

I created the v2 patch but I do not know why it was not recognized. I
have attached the patch file here.

On Thu, Oct 12, 2023 at 9:35=E2=80=AFAM Muhammad Muzammil
<m.muzzammilashraf@gmail.com> wrote:
>
> resolved typing mistake from devce to device
>
> changes since v1:
>         - resolved another typing mistake from concurent to
>           concurrent
>
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---
>  drivers/net/wwan/wwan_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 87df60916960..72e01e550a16 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwand=
ev)
>
>  static const struct {
>         const char * const name;        /* Port type name */
> -       const char * const devsuf;      /* Port devce name suffix */
> +       const char * const devsuf;      /* Port device name suffix */
>  } wwan_port_types[WWAN_PORT_MAX + 1] =3D {
>         [WWAN_PORT_AT] =3D {
>                 .name =3D "AT",
> @@ -1184,7 +1184,7 @@ void wwan_unregister_ops(struct device *parent)
>          */
>         put_device(&wwandev->dev);
>
> -       rtnl_lock();    /* Prevent concurent netdev(s) creation/destroyin=
g */
> +       rtnl_lock();    /* Prevent concurrent netdev(s) creation/destroyi=
ng */
>
>         /* Remove all child netdev(s), using batch removing */
>         device_for_each_child(&wwandev->dev, &kill_list,
> --
> 2.27.0
>

--000000000000cb1c7606077ee616
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-drivers-net-wwan-wwan_core.c-resolved-spelling-mi.patch"
Content-Disposition: attachment; 
	filename="v2-0001-drivers-net-wwan-wwan_core.c-resolved-spelling-mi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lnmsfg6v0>
X-Attachment-Id: f_lnmsfg6v0

RnJvbSAwMjhmNjhjZWM4OGNkMDEzZjQ0MzM4OGU5NGY3OWFhNmEzNTU2YTRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBNdXphbW1pbCA8bS5tdXp6YW1taWxhc2hyYWZA
Z21haWwuY29tPgpEYXRlOiBUaHUsIDEyIE9jdCAyMDIzIDA5OjI1OjQ5ICswNTAwClN1YmplY3Q6
IFtQQVRDSCB2Ml0gZHJpdmVyczogbmV0OiB3d2FuOiB3d2FuX2NvcmUuYzogcmVzb2x2ZWQgc3Bl
bGxpbmcgbWlzdGFrZQoKcmVzb2x2ZWQgdHlwaW5nIG1pc3Rha2UgZnJvbSBkZXZjZSB0byBkZXZp
Y2UKCmNoYW5nZXMgc2luY2UgdjE6CgktIHJlc29sdmVkIGFub3RoZXIgdHlwaW5nIG1pc3Rha2Ug
ZnJvbSBjb25jdXJlbnQgdG8KCSAgY29uY3VycmVudAoKU2lnbmVkLW9mZi1ieTogTXVoYW1tYWQg
TXV6YW1taWwgPG0ubXV6emFtbWlsYXNocmFmQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93
d2FuL3d3YW5fY29yZS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3Jl
LmMgYi9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jCmluZGV4IDg3ZGY2MDkxNjk2MC4uNzJl
MDFlNTUwYTE2IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jCisrKyBi
L2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMKQEAgLTMwMiw3ICszMDIsNyBAQCBzdGF0aWMg
dm9pZCB3d2FuX3JlbW92ZV9kZXYoc3RydWN0IHd3YW5fZGV2aWNlICp3d2FuZGV2KQogCiBzdGF0
aWMgY29uc3Qgc3RydWN0IHsKIAljb25zdCBjaGFyICogY29uc3QgbmFtZTsJLyogUG9ydCB0eXBl
IG5hbWUgKi8KLQljb25zdCBjaGFyICogY29uc3QgZGV2c3VmOwkvKiBQb3J0IGRldmNlIG5hbWUg
c3VmZml4ICovCisJY29uc3QgY2hhciAqIGNvbnN0IGRldnN1ZjsJLyogUG9ydCBkZXZpY2UgbmFt
ZSBzdWZmaXggKi8KIH0gd3dhbl9wb3J0X3R5cGVzW1dXQU5fUE9SVF9NQVggKyAxXSA9IHsKIAlb
V1dBTl9QT1JUX0FUXSA9IHsKIAkJLm5hbWUgPSAiQVQiLApAQCAtMTE4NCw3ICsxMTg0LDcgQEAg
dm9pZCB3d2FuX3VucmVnaXN0ZXJfb3BzKHN0cnVjdCBkZXZpY2UgKnBhcmVudCkKIAkgKi8KIAlw
dXRfZGV2aWNlKCZ3d2FuZGV2LT5kZXYpOwogCi0JcnRubF9sb2NrKCk7CS8qIFByZXZlbnQgY29u
Y3VyZW50IG5ldGRldihzKSBjcmVhdGlvbi9kZXN0cm95aW5nICovCisJcnRubF9sb2NrKCk7CS8q
IFByZXZlbnQgY29uY3VycmVudCBuZXRkZXYocykgY3JlYXRpb24vZGVzdHJveWluZyAqLwogCiAJ
LyogUmVtb3ZlIGFsbCBjaGlsZCBuZXRkZXYocyksIHVzaW5nIGJhdGNoIHJlbW92aW5nICovCiAJ
ZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKCZ3d2FuZGV2LT5kZXYsICZraWxsX2xpc3QsCi0tIAoyLjI3
LjAKCg==
--000000000000cb1c7606077ee616--
