Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970157D383A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJWNg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJWNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:36:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A1D9B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1698068168; x=1698672968; i=frank-w@public-files.de;
        bh=bHX9uY0n1jxgv5A7K/dCOBwnI4isugh0B1x9wed8QHc=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=Tf9klKPGfMXfI06FbAggnF8skruvRXW04BOyiFURlpxqBoaug8zLNPyy03bQF8XN
         bWWdUDOUoot1ceSCImZCJiwuZG0cIdSlLAkf9vfvTMlxV1XC2/EG94HEFgrXCJnPz
         2deYIXQ4jQiyqXjVwTuodNofcC/JRCR+ETDXbfC/7pmCcxcMvqTiy5KFBE9qlBY2W
         rDrQfETwQdEjEUBmZ6N0Amq24yLPvc4mqxHz/iTnRuJBGKlHxrRwndFOQrLlgrrr4
         zmMSxdS93D1YQ79Rfiuws3scPRvI36IPv5GHCbtdAU6PsTIaYiUYrC6TJqyq4PAlT
         I8JFS4NSpA8lpuMkhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.159.145]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1rGjCe3k8Z-00nPd7; Mon, 23
 Oct 2023 15:36:08 +0200
Date:   Mon, 23 Oct 2023 15:36:08 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Subject: =?US-ASCII?Q?Re=3A_Aw=3A_=5BRFC_v1=5D_arm64=3A_dts=3A_mediatek=3A_a?= =?US-ASCII?Q?dd_dtbs_with_applied_overlays_for_bpi-r3?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <9c1a1119-3257-44dc-8223-7992ea6c86ac@linaro.org>
References: <20230916083214.7059-1-linux@fw-web.de> <trinity-3fe161a2-70f1-4619-be28-199ea6201668-1696078629921@3c-app-gmx-bs36> <trinity-13c822b5-7d6f-4bd0-863f-8f98b1a8689b-1698062394687@3c-app-gmx-bs46> <9c1a1119-3257-44dc-8223-7992ea6c86ac@linaro.org>
Message-ID: <29DCF69F-41B5-4BFB-9539-7ADCC52104ED@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SEgFZ4eJTbDGHg/lzCFATStNZMzwiLIDyp/MPCJx+qd9kBVNELE
 ghwfE2yKSYCQ0qTv/o+MXTQcMnzHBAV+EA2WlLziMvIuGbwskr56KFqrRgxKGJpEgHHi19S
 kjd76WgWZrWWcvWC7ASEcnPoQ9hYvosROqj63TDMiALsHqG7k7s+SHm4kV4TWycB16aoXz+
 xzxVkUhVu4KxvioqAihaA==
UI-OutboundReport: notjunk:1;M01:P0:bvf2UyTccBk=;cWEI/gCcaDj4zOvlh7yQXZOckMy
 7tCGqAmK8KaSg7HRspzTzAQ+Qc/awhkrYzQ8VXofBf2JcdyRy24B99Z6yBI9FGza0LxAG/Uj3
 bHKQyQBN435dn1P3i7IgCjxavUnoIcv/sLAxLW7cF2NFPGejnJT5XqTFvYjorfiFTVbWhTdgq
 IKnk4d15i0IjZCA5PyRqGnSDSCrfUTcCdVn8sLUDMDAaT69JmsIM/mIzh65UVWW30b6TR+bBN
 SCB+4QQbCdfCPqlJFKzxHH57sIG7amOUWOQHzZMex0S3NQc8NwZGcETMYR9NroX4iJO3LbS0N
 oP5+o2aQHIPzxKoipuwHcHS2s+UK+HJdBqd1C/eogjjJhxBeS10nEtq8Nc3xu7Kh21zNahDSW
 ehLOzvnYdPIbueydkIJPxfBE/UAk/b8ZT8jTWydfTD+aernsMbWkbY2hq0nR4mH/QQ42SaH4p
 jH56dxMCrd8g6/VA8pd6xph3SoLu0ZKZlgoWjMoWq0bqM4V+NuyGRA9KU+PDbrmKYkA+Lcr6t
 dBY6O1ufXq2oTPlWsjB2pWCu5Skq8++9Tqb63ZzeWxfYFRXrE0Id2L1FHD+zbOCqwwPXChkO4
 Ip9WdaXZWCnuDnmHS+2lbmjVgruN2/ewr7O5T9+tYfnIeWy8b8YsziVF+gdxwcsNj98L5CaTh
 gcz75ThRK9lxkMN8wc3LhmR5qpb+9+aRmy20t42oiBhJSvoage3IZYBdF81GYlRb09l/fSViR
 4+Q4QTcgf+WIRES9IL2xIaONxrAPv928FtRIBKwF0cPSCaJO+beDAeDvqzMf4k2GhyrQMhhI+
 r1wxBGlIpt5OWAtK1bxom6gn8bgGOYW+0KRY+tvcWJAUgONJy4Us8GUbpSkcV1JEegdU7O8fL
 PIcmcyt56Qumpmtm+QoMNpY4hzjpy4ZWEppvTMqZYuZKu6mtmcWXjM0stFW8vGwEPanHjNYc7
 Ygrtnw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23=2E Oktober 2023 15:25:27 MESZ schrieb Krzysztof Kozlowski <krzysztof=
=2Ekozlowski@linaro=2Eorg>:
>On 23/10/2023 13:59, Frank Wunderlich wrote:
>> Hi Rob/Krzysztof
>>=20
>> can you please give an Ack or tell me if something is wrong?
>
>Hm? I do not recall being the maintainer of Mediatek=2E Why do you need a=
n
>Ack from me?
>
>Best regards,
>Krzysztof
>

I asked you because rob suggested the fix,but does not confirm i have done=
 it right=2E I guess you have same role,or am i wrong here (sorry then)?

If no ack is needed, then mtk maintainer can apply it to solve the problem=
 rob reports? So then we can continue with additional dts changes
regards Frank
