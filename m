Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5D7517A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjGMEnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjGMEnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:43:06 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC431FC9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:43:04 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230713044301epoutp0151b6562ef3ddc64fba38215fabf11b73~xU7dA1tQ10211902119epoutp01I
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:43:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230713044301epoutp0151b6562ef3ddc64fba38215fabf11b73~xU7dA1tQ10211902119epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689223381;
        bh=jnrbdUvnu2pvYRlibF+/arqX32ZF1+0djsgqKI7ySIc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ng76qHqIFw4ZnoqnDBQo07nDEw2iX0Qle5+g3YB/Ku+j/bwfR1uVphFCkaOtE3n5H
         tvMHVHjWQ7xMeDt8GjxxqJgTUv4vCVx/n15htDTvcwVHOs5/vMlSOYOjiGyNf9Towd
         UDd+E01y/GBzHVPYpts8YTx5pm/SJKIIY/PxwlxY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230713044301epcas1p46717b593de832342203ad87252fe3bb1~xU7cZaDn72021020210epcas1p4x;
        Thu, 13 Jul 2023 04:43:01 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.134]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R1hmz5WcDz4x9Pv; Thu, 13 Jul
        2023 04:42:59 +0000 (GMT)
X-AuditID: b6c32a35-f8fff70000008374-3c-64af80d31aee
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.6B.33652.3D08FA46; Thu, 13 Jul 2023 13:42:59 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] dt-bindings: extcon: extcon-usb-gpio: convert to yaml
 format
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     David Heidelberg <david@ixit.cz>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230713002519.109392-1-david@ixit.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230713044259epcms1p3a4de07b9ec965a30ac908619c47d6139@epcms1p3>
Date:   Thu, 13 Jul 2023 13:42:59 +0900
X-CMS-MailID: 20230713044259epcms1p3a4de07b9ec965a30ac908619c47d6139
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmge7lhvUpBv/3aFpc//Kc1eLYPnuL
        +UfOsVr0vXjIbDHlz3Imi8u75rBZtO49wu7A7tHfeJDZY9OqTjaPO9f2sHn0bVnF6PF5k1wA
        a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAtMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7Ixl5/4zF1znqdj6dy5jA+NSni5GTg4JAROJd5M3sYPYQgI7GCWWv6jtYuTg4BUQlPi7Qxgk
        LCwQLLHs6yWoEiWJhpv7mCHi+hIdD7YxgthsAroSWzfcZeli5OIQEbjKKHFx9yOwImaBOol1
        3bvYIXbxSsxof8oCYUtLbF++FayZE+iGNRt+MUHERSVurn7LDmO/PzafEcIWkWi9d5YZwhaU
        ePBzN1RcSuLJzslsIIslBLYxSuw4MgfK2c8oMeVhG9QkfYkzc0+ygdi8Ar4SS1dMB+tmEVCV
        OHtpAVSNi8SkeX/ZIa7Wlli28DUzKCSYBTQl1u/ShwjzSbz72sMK88yOeU+gjlaTOLR7CdQY
        GYnT0xdCHeohce3MSWZIyFVLnJ+5gXUCo/wsRPjOQrJsFsKyBYzMqxjFUguKc9NTiw0LDOEx
        mpyfu4kRnAq1THcwTnz7Qe8QIxMH4yFGCQ5mJRFelW3rUoR4UxIrq1KL8uOLSnNSiw8xmgK9
        OZFZSjQ5H5iM80riDU0sDUzMjIxNLAzNDJXEeZkf9aYICaQnlqRmp6YWpBbB9DFxcEo1MF2+
        I/z2qqS4iiVz1e4FVs++cOj+mTJn50kxwcU7vLjfmy28G1Q+2/DHabMYXcN3xRds/kUHNC5Y
        feC0m1uvwWZN4Vs9cu4MbksmpX7cfs05Y5lt4IdrTXcLNXVdiv+3FSyTD7Y+m+e6cJqt2/Hc
        z5J3ft1XtlLdKcVm0Tnd/uDTVys2G8d7HdBN3Sr2vOCr9Js1RUZfztm3TZ5XeybYPXu+u8vN
        584X1njsXvsjMzfsyYsD9VyTVs2p/qRjutsxcPaqPba9nVtWsaz1urhC9HBNG+tqeeZVeWYb
        S/yOH+N/Vrz1dcrqg2bvX+V+UtrwN7kjcCrH5BTJudJTpz+Pj2LhaJStf3gp4RhDyq7QCe+V
        WIozEg21mIuKEwGYKoSoDgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230713002537epcas1p3a1b2049dd05d42a6c9df26edf7988ca6
References: <20230713002519.109392-1-david@ixit.cz>
        <CGME20230713002537epcas1p3a1b2049dd05d42a6c9df26edf7988ca6@epcms1p3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>--------- Original Message ---------
>Sender : David Heidelberg=C2=A0<david=40ixit.cz>=0D=0A>Date=20=20=20:=2020=
23-07-13=2009:25=20(GMT+9)=0D=0A>Title=20=20:=20=5BPATCH=5D=20dt-bindings:=
=20extcon:=20extcon-usb-gpio:=20convert=20to=20yaml=20format=0D=0A>=C2=A0=
=0D=0A>Signed-off-by:=20David=20Heidelberg=20<david=40ixit.cz>=0D=0A=0D=0AA=
cked-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A>---=0D=
=0A>=20.../bindings/extcon/extcon-usb-gpio.txt=C2=A0=20=C2=A0=20=C2=A0=20=
=20=7C=2021=20---------=0D=0A>=20.../bindings/extcon/extcon-usb-gpio.yaml=
=C2=A0=20=C2=A0=20=C2=A0=20=7C=2045=20+++++++++++++++++++=0D=0A>=202=20file=
s=20changed,=2045=20insertions(+),=2021=20deletions(-)=0D=0A>=20delete=20mo=
de=20100644=20Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt=
=0D=0A>=20create=20mode=20100644=20Documentation/devicetree/bindings/extcon=
/extcon-usb-gpio.yaml=0D=0A>=0D=0A>diff=20--git=20a/Documentation/devicetre=
e/bindings/extcon/extcon-usb-gpio.txt=20b/Documentation/devicetree/bindings=
/extcon/extcon-usb-gpio.txt=0D=0A>deleted=20file=20mode=20100644=0D=0A>inde=
x=20dfc14f71e81f..000000000000=0D=0A>---=20a/Documentation/devicetree/bindi=
ngs/extcon/extcon-usb-gpio.txt=0D=0A>+++=20/dev/null=0D=0A=5B=5D=0D=0A>diff=
=20--git=20a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.yaml=
=20b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.yaml=0D=0A>ne=
w=20file=20mode=20100644=0D=0A>index=20000000000000..b345745013a2=0D=0A>---=
=20/dev/null=0D=0A>+++=20b/Documentation/devicetree/bindings/extcon/extcon-=
usb-gpio.yaml=0D=0A=5B=5D=0D=0A
