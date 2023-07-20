Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53375A6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGTGtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGTGtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:49:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF610A;
        Wed, 19 Jul 2023 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689835768; x=1690440568; i=deller@gmx.de;
 bh=HZ7rg6AhbQrQ6e7Xq6bBlCGjxjfoM64OtgN0BKs/8YQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EjLiR1ouuZUCT+SNzkAyFPOHlqda/bHE5x2CaZRgACJRdu9wsbkzEggpFOZ8F4MQ2iiKIwu
 9rS3MyOiTdrntW6+Xy1JFFvR5xY9W/G23tbdrQTfvWfcnBDNYKDJBdCmNZeLGJfwx6Qzd8HSO
 6cvyv6a5orygDgu851k53WBXf9ajJPfGhUge1KDJy5v6IRqEk+c0oBjTvWQTOdTBmyQ3xFUq4
 Vv5ecKnxbInURErcbNPU6ohg2/lAb0Q8NopyxuBTS1GI76+fK28esSV1jAPvfUFebrqdYjHLM
 shtj/xpQjb9wHNimf25Z89ntl9k2G4BjJhqJ0554oK/w66VPEdCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.9]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1qejfv1zxD-00IVXd; Thu, 20
 Jul 2023 08:49:28 +0200
Message-ID: <5603e84b-656b-e0b2-14ef-13f4e1062552@gmx.de>
Date:   Thu, 20 Jul 2023 08:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] parisc: math-emu: fcnvxf: Add space after that ','
Content-Language: en-US
To:     hanyu001@208suo.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_86762B5284E20421D8A676F4CC1B205D2F0A@qq.com>
 <a2ae26be540da062ea4912c36962093b@208suo.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <a2ae26be540da062ea4912c36962093b@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q9WgkOpkJnkqrKbIKi7caJsirmzwbDML/OhqQyMS5bHREYZdHsc
 xqNH19PsLzVdqbqVa9cNQoSFkWPZsyQWeWMO1o4I9id47AcFZHc+Oimy6p1X7RyAesYr+8+
 IjUU5c7ZMn1AfHsOYmZmjlyjfoyGi27fHA4zZ0rnAATM1pAZusk4Vlrx5EwGU4ZmXsxyQBM
 5bXAx6w44JW5PEy/Qwe1A==
UI-OutboundReport: notjunk:1;M01:P0:kLAIqU58eDM=;fkyra3ddEZ8kgnJobsX2Y9tFqtd
 LzwKuCLFp2Nx/FtwmnT1rx2cQbrYh2IgzG0MPvjZpO3y2PC4YrQXMhlaXRK2LbtwZU1mKl1/Q
 7rL+mi2XO1BFuupyBPzgA/7GaQ8XVfJ/UaQHYDx1Wa036MiZQjGgi3bxcqaFj5ptzGXBE7MO6
 JBK0ipplLLqNfcHnmkbKeg25OEo50NnBWJiwHrU5qcCd6UXlhaKBDeUywdEBG0GKQCWfSwFCf
 v3KNwHRpKGIRfi/vF8d0ok6iJvQEWXh2L7Mb1MZ+lk8dNzwqct4nEKR7gOLJuEfEKTCI7Vj/q
 XobskLGU17/jXMn1EPaRbrxnzwWkxNybq/XuEcvU7Ub2gHfMPvOtAGxwT97Vftl/sGkAK+mEM
 oE+lqmYY6rSqaXVf7qeaMEEx4X/Emr44dBMWM0bIzBqjYeFF65/GIpgGT2D8T+13OGQbWMhiF
 KA1fo2XZiX+VaYAdCu3ldKs9fD9XZQ641zz+orzzcWmTGrX5yDNiDyHIB6T5xMF81XjtK4qCf
 a0gi/WcuhmssWLptnWt2F17yFJZcxKElpzaOh4swSosd9aTL/qaq1Bnj601uMsRriaS3YUw27
 YvpeioO4AMvQi0QTaG1NvmR7AdV91d/8QKUsv2AGT7T6HY/b5pH5l2l4AWa3qZgGyKo3auffC
 9hIUjsyPWaB2o5RSlbDS4BxUMz1vNFSfDaP73qrTzONKDx62PU9KLQ0ANW86BI7PsSVvspLf9
 NrnaWAye+BmeS+jSFTCxci7SXV7dA5o/0MQJdylSZphg1Hqs6AmI5Y3AdEAutjdYJna+oVUvI
 tQuiga/aJ35p47jkS2AbiyOmkpwxTr4eDBQdLlVr1IXl53l1Kcm35AOX9k2Xq2LKaIIdo2KZ/
 ouK8xs6I0d6ECPQwHEhYjqN0TOwvKmy3wmvlXwmX/90Nm8Lf0n31/DLXSwOsmtpMc+VIkgl6i
 ip3hTNPc8G4jXETLg5pfvPeyxL8=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello hanyu001,

On 7/13/23 11:37, hanyu001@208suo.com wrote:
>
> Fix Error reported by checkpatch.pl
>
> arch/parisc/math-emu/fcnvxf.c:99: ERROR: space required after that ',' (=
ctx:VxV
> )
>
> Signed-off-by: maqimei <2433033762@qq.com>

Thanks for that patch!

Your patch is correct and as such it should be applied.
But please notice the arch/parisc/math-emu/README file (in the same
directory), which states:
All files except driver.c are snapshots from the HP-UX kernel.  They've
been modified as little as possible.  Even though they don't fit the
Linux coding style, please leave them in their funny format just in case
someone in the future, with access to HP-UX source code, is generous
enough to update our copies with later changes from HP-UX -- it'll
make their 'diff' job easier if our code is relatively unmodified.

So, I won't apply any patch to that directory, unless it fixes a real bug
or is required to compile the kernel.

Thanks,
Helge

> ---
>  =C2=A0arch/parisc/math-emu/fcnvxf.c | 2 +-
>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/math-emu/fcnvxf.c b/arch/parisc/math-emu/fcnvxf=
.c
> index 6940179..f5f9376 100644
> --- a/arch/parisc/math-emu/fcnvxf.c
> +++ b/arch/parisc/math-emu/fcnvxf.c
> @@ -96,7 +96,7 @@
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sgl_increment(result);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case ROUNDNEAREST:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Sgl_roundnearest_from_int(src,result);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Sgl_roundnearest_from_int(src, result);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (Is_inexacttrap_ena=
bled()) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *dstptr =3D result;

