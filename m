Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3ED7B00AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjI0JjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjI0Jio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:38:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF6A19F;
        Wed, 27 Sep 2023 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695807516; x=1696412316; i=julian.ribbeck@gmx.de;
 bh=16t7el8IewpM1cnIsu1QxjB2nxpYRgSW1dxpkHZLK/E=;
 h=X-UI-Sender-Class:Date:Cc:Subject:From:To:References:In-Reply-To;
 b=dnolXnLRs/LGLCmJnKFKVvHmoFb0cf9/Gn2kobhTgOVjV0xW/gzedFzd7s0lTD7rl4jth3Kh5Pu
 gfjqTm+SQyIT6ACY9YQ5Iu7Cy+EXItYzhizDmKFiRJNBlUccGMQsWj3R5xJQpO8nXYanTav0/Qg8V
 OIw6Gur0zCEjxPrfvpiriHNpjauDNJjmA8MqLlRP1Qu3G/W9ijy6qYl+GqEV0TTMlq9MXz9B6KOgW
 YRZlDmBMYcQUVRXFH8PPx8e0OvUzbaz/q9aFJjz4jHBzrC6PAB4z65GOOv/SxZgxgmMNxMtq6ot2J
 G5lALXnAD0DLOh4oGdhsxAs2zPNCenyhWxpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([95.90.255.242]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1qsFxk3fiB-00HKHI; Wed, 27
 Sep 2023 11:38:35 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 27 Sep 2023 11:38:35 +0200
Message-Id: <CVTLLDPXFP5D.ANP0YTD5AD0P@x1-yoga-arch>
Cc:     <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: sunxi: Add
 itead,iteaduino-plus-a20
From:   "Julian Ribbeck" <julian.ribbeck@gmx.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
X-Mailer: aerc 0.15.2
References: <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
 <20230617205624.1178427-1-julian.ribbeck@gmx.de>
 <20230617205624.1178427-2-julian.ribbeck@gmx.de>
 <bba4acf9-23a4-d732-900b-944c4ddef08c@linaro.org>
In-Reply-To: <bba4acf9-23a4-d732-900b-944c4ddef08c@linaro.org>
X-Provags-ID: V03:K1:4EpkK8TTjI4S+YuKNBwvdQlGei/Yz19h1WVGU16+3dJHxxk6bbz
 dS/FMR1rXfvzaptnajrE2kAo9/qmNaVNb02uI3uprmD85ML5OaqbsCBrNUQufW7uWMM/4HI
 gF0H3n4skSXA+Paa16vJoOLGCzuiMks0GFUDNfYYnKau29EfZYWu0fvYL7/mAdc/jdf2A4w
 zBHKg/SFoXZzCaWutbgOQ==
UI-OutboundReport: notjunk:1;M01:P0:na5xKnskk8M=;EhFKlijxBVWKLU2PDJhuNm/rmJN
 HHHuEKwHVTppvmnAYu/R3vgiVuHayEA0fxz2pS4Hu9FYRk9GvwO9Y/e48fOeZ+gdzS4M4Y7Y6
 Fa4K5XAfYEkDYY1ULbHBMpgRbD/W8+IaNk5ksWKwzYguZKxfk8lh8LTVZSEwG6wJChY2lZJqI
 k07e5Ib+ENSeF1DBiMSfJwWooRPrMPRslxTEnIYjez6eTvHpqfc5Kys2V9R20ktSUgqCC8Dpk
 udbksqekedjdbOU4nEkdjPIx0iwwpceOZJXenUqHr/RoJHgn0logD6rmVUEokfttK9x5Zy+v2
 HecceqKP7zi4pOtGr4S3dpaCnXa2SpPy4mq4clc7dXSI2Gt94/NHf0TUXmnGVV1wC0Y6d0Kfw
 yI6NGqhP9gqK816JJQoscOA65N7dfTUsT7ffoTG2/IuhpF7QWIeDLpZbImIbMVG8M0KWEUQ3s
 k1p3dVOAvrq8+36FRv/7uyyDmIi9UckI8t0aExampMlU5lEwPncKw7/IOD1XP11uKNT+pyeMn
 Hjz2ZCjiOWbEwIfx0bhv2Tlp+iBvwUkLzyGpwPg9hnkrr+VOdPVSwTrBqGfDsin1YLKk6qto9
 sOQNPaG8BLkG8avjGR/r2eH4uk52x63xlaNAKoYzzidrk6w6yg5gkRrETcneyFWyGGYEeGWdJ
 X/F68na/XEg+BdOFWcNPa9T52z3NgiwbkRQOvumMMtCmGNmk90jw72wXjVj+z2XkUx9kDKgOe
 pQwz5QLnh8f6dKg/8Nr6zhY3nwWUl7yJf5FJFwo92kxvXIB6Xw5KBzSxCF/lVzZZhOEElH54G
 USz3YyOmQVhZU5PmJ5obMLePZMp9N72R9dHLXtDtiE7OYaaQnDGoqOKGJ/0pKE0rLtjX1kBzz
 wAnrjk2YbDY+M4BBPMoXm04jHpXsMpzUvS1qAsPDTA561kTptEJeU3yclLM43NIQEI59AYhNF
 TYX4degonYaVlXtAB6pzfx9Qi0I=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not totally familiar with the process here, but it seems like my
patch was kind of forgotten? What should I do now? Is anything still
missing?

Greetings
Julian

On Sun Jun 18, 2023 at 10:00 AM CEST, Krzysztof Kozlowski wrote:
> On 17/06/2023 22:55, Julian Ribbeck wrote:
> > Add itead,iteaduino-plus-a20 bindings
> >=20
> > Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
> > ---
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

