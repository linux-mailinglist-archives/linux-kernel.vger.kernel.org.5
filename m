Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8C75B3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGTQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:15:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01F114
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:15:22 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a1e6022b93so702949b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689869722; x=1690474522;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spRc2zjfCJ2GinXpJojBZx1iEaktryHjeuAgiddSObg=;
        b=UZpR6zPaxHX+wh0hm7aR6jFnBLbpFsorGdiXNSp1EuDmlk9r9Jwb46wQcI5WszFjPw
         DcuMXYwmL++OQGIU2JlZdXGx1ZlNeBIkrMJVpi5diGOaQGULaqoM/XeoJNgrm5duitDu
         0SjFa5ZvrIem/oRs9B0cdyxpHYPMFnsuT+Orw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869722; x=1690474522;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spRc2zjfCJ2GinXpJojBZx1iEaktryHjeuAgiddSObg=;
        b=NUbNAuRd1PuDsjKMqMadrvUxJIDAA+tCYsRIst3Ow61+kv5aQpRDeXbDwSAGk8UxaB
         UM4c0OmuaVLF8DkgdhVmDy5AihzfR0RuO5wLNnMMJrEUbEu74XmCmuTfpxXyGLBFJbsN
         J8uWnRedCM27jDad2PHKBOQwc9ZWLZhrzBWtQMrbgY8l6OtIYbjiu1Aey278dKDjhAP5
         Py+95H9Bc03wsbhAttFU54pctst2up4/PRKGLuPEtyQlxlQFyIFw95Hf/AjMgUnpmNVM
         D+9vIUsXfkSSnQTHynTEztCZSWUC/p1zlUqA2fy5dyYr0fISs1HgKvTthXeenl1KHLov
         Ph5g==
X-Gm-Message-State: ABy/qLan2FvDhHaPkSEExbx0Agt4YMP74aFN1JgDK1C27PxT47Sv/b3r
        n6+d4Vc0smcul3mWTXBnVrJNog==
X-Google-Smtp-Source: APBJJlFfRZ5bh0qibQ/kW3t5QnDkPsvCNuHHN3xX3sEkGo8zkQ9xDuynTMMl8M+gbiRwRUDGul/iPw==
X-Received: by 2002:a05:6808:1289:b0:3a1:e3ee:742a with SMTP id a9-20020a056808128900b003a1e3ee742amr11816oiw.8.1689869722099;
        Thu, 20 Jul 2023 09:15:22 -0700 (PDT)
Received: from [192.168.86.135] ([136.52.74.64])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090a854100b00265c3456645sm2845868pjw.18.2023.07.20.09.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 09:15:21 -0700 (PDT)
Message-ID: <cbe8fade-68f7-43ee-ac51-e35fcc3dc1a5@broadcom.com>
Date:   Thu, 20 Jul 2023 09:15:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] MAINTAINERS: net: fix sort order
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
References: <20230720151107.679668-1-mkl@pengutronix.de>
From:   Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20230720151107.679668-1-mkl@pengutronix.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000084fbaa0600ed74db"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000084fbaa0600ed74db
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/2023 8:11 AM, Marc Kleine-Budde wrote:
> Linus seems to like the MAINTAINERS file sorted, see
> c192ac735768 ("MAINTAINERS 2: Electric Boogaloo").
> 
> Since this is currently not the case, restore the sort order.
> 
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Justin Chen <justin.chen@broadcom.com>
> Fixes: 3abf3d15ffff ("MAINTAINERS: ASP 2.0 Ethernet driver maintainers")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Justin Chen <justin.chen@broadcom.com>

> ---
>   MAINTAINERS | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b123afcfc9e..66a06ac9729e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3838,6 +3838,15 @@ S:	Maintained
>   F:	kernel/bpf/stackmap.c
>   F:	kernel/trace/bpf_trace.c
>   
> +BROADCOM ASP 2.0 ETHERNET DRIVER
> +M:	Justin Chen <justin.chen@broadcom.com>
> +M:	Florian Fainelli <florian.fainelli@broadcom.com>
> +L:	bcm-kernel-feedback-list@broadcom.com
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> +F:	drivers/net/ethernet/broadcom/asp2/
> +
>   BROADCOM B44 10/100 ETHERNET DRIVER
>   M:	Michael Chan <michael.chan@broadcom.com>
>   L:	netdev@vger.kernel.org
> @@ -4148,15 +4157,6 @@ F:	drivers/net/mdio/mdio-bcm-unimac.c
>   F:	include/linux/platform_data/bcmgenet.h
>   F:	include/linux/platform_data/mdio-bcm-unimac.h
>   
> -BROADCOM ASP 2.0 ETHERNET DRIVER
> -M:	Justin Chen <justin.chen@broadcom.com>
> -M:	Florian Fainelli <florian.fainelli@broadcom.com>
> -L:	bcm-kernel-feedback-list@broadcom.com
> -L:	netdev@vger.kernel.org
> -S:	Supported
> -F:	Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> -F:	drivers/net/ethernet/broadcom/asp2/
> -
>   BROADCOM IPROC ARM ARCHITECTURE
>   M:	Ray Jui <rjui@broadcom.com>
>   M:	Scott Branden <sbranden@broadcom.com>

--00000000000084fbaa0600ed74db
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQagYJKoZIhvcNAQcCoIIQWzCCEFcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3BMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUkwggQxoAMCAQICDCPwEotc2kAt96Z1EDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjM5NTBaFw0yNTA5MTAxMjM5NTBaMIGM
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0p1c3RpbiBDaGVuMScwJQYJKoZIhvcNAQkB
FhhqdXN0aW4uY2hlbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDKX7oyRqaeT81UCy+OTzAUHJeHABD6GDVZu7IJxt8GWSGx+ebFexFz/gnRO/sgwnPzzrC2DwM1
kaDgYe+pI1lMzUZvAB5DfS1qXKNGoeeNv7FoNFlv3iD4bvOykX/K/voKtjS3QNs0EDnwkvETUWWu
yiXtMiGENBBJcbGirKuFTT3U/2iPoSL5OeMSEqKLdkNTT9O79KN+Rf7Zi4Duz0LUqqpz9hZl4zGc
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEkYy3SS7sCqOJzeXN5n0OARf9XmZnXgyLtC
aCNJgI5UMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcyMDE2
MTUyMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQArzwiuecADjwrH78GsQWRsQ1AxrklTELj0uTCFsSIbPnaxIAIKkwor
zl7xv6dGi6m0y/ni+vSRrQRzT1muHRzM96OQ/e0jJqTvup9KQOm7UjL/quxol5xtoYMQjKM8p3pa
YVnBMq1wHZgB407Pf1ASkiXi1WiRjg+pQx5o6/0odDOEEp4dygF7r8hAMC2UP+t5CqUNPuBdO9yp
+lK8evg9+yKBH+sl2bTsOzDV0lXHMV5HObXdXDqBCHJfUaCNzqiYySLRB0/t8JwFOUI56PUg3CzF
XdTgzdifDtj4UCYEgzhGbiMz/hNXIXnt3+wIrnUtBBFBo2ektcNOMfjgM1D3
--00000000000084fbaa0600ed74db--
