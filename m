Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D955275604E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGQKWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGQKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:22:43 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006021A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:22:40 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230717102238epoutp033617f85ce37a695d26e25112f8a6bcdd~yoJHQTBGt0477004770epoutp03X
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:22:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230717102238epoutp033617f85ce37a695d26e25112f8a6bcdd~yoJHQTBGt0477004770epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689589358;
        bh=QXlUxrsCGtkNKAprN1eyVdXGbJvLtJq6lDQVTi+s8Rg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=OgLnwMwe3sC7+SfxUG3pXCCloZcCNpU/5Ldbk4fNipo0nVqcG7zvLzoEskP5tm8v6
         NVTpAsFkfELNNpdfPLqrjsWdj1i4CSBObZ3ThaXvmVt08nhEz6wq7tMtDPoMId4U4U
         J8QGIQ7FQ9GJIRqscyTdEl7MxVqtt+sP7m6JdNBk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230717102237epcas1p3b73f80294b3f7c2723ec5c190327dd87~yoJGjJGRP1108611086epcas1p30;
        Mon, 17 Jul 2023 10:22:37 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.135]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R4J710Xt5z4x9Q1; Mon, 17 Jul
        2023 10:22:37 +0000 (GMT)
X-AuditID: b6c32a4c-a4fff70000053013-01-64b5166c8115
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.86.12307.C6615B46; Mon, 17 Jul 2023 19:22:36 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] drivers: extcon: space required after that ','
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "hanyu001@208suo.com" <hanyu001@208suo.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <25d422c1ac26f0c59ef10a8a2afe057b@208suo.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230717102236epcms1p37cc0359d33b47b274f88a9e99a923787@epcms1p3>
Date:   Mon, 17 Jul 2023 19:22:36 +0900
X-CMS-MailID: 20230717102236epcms1p37cc0359d33b47b274f88a9e99a923787
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmvm6O2NYUg2szrS2uf3nOarHk2xQ2
        i8u75rA5MHtcOGXj0bdlFaPH501yAcxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
        lhbmSgp5ibmptkouPgG6bpk5QHuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWm
        BXrFibnFpXnpenmpJVaGBgZGpkCFCdkZM6asYCpYxV6xcutr1gbGN6xdjBwcEgImEre2l3Yx
        cnEICexhlGj5+4sNJM4rICjxd4cwiCks4CwxrdWji5ETqERJouHmPmYQW1hAX6LjwTZGEJtN
        QFdi64a7LCC2iEC4xO3292A2s4CjxO29b5lAbAkBXokZ7U9ZIGxpie3Lt4L1cgpYSRz6cB6q
        RlTi5uq37DD2+2PzGSFsEYnWe2eZIWxBiQc/d0PFpSSe7JzMBnK+hMA2RokdR+ZAOfsZJaY8
        bIOapC9xZu5JNhCbV8BXYtXR2WBxFgFVif72z1A1LhKnn7czQlwtL7H97RxmkOeZBTQl1u/S
        hwjzSbz72sMK88yOeU+gjlaTOLR7CdQYGYnT0xdCHeoh8asT5ElQ2O5klNi//i37BEb5WYjg
        nYVk2yyEbQsYmVcxSqUWFOempyYbFhjq5qWWwyM1OT93EyM4qWn57GD8vv6v3iFGJg7GQ4wS
        HMxKIrzfV21KEeJNSaysSi3Kjy8qzUktPsRoCvTrRGYp0eR8YFrNK4k3NLE0MDEzMjaxMDQz
        VBLnjfnUniIkkJ5YkpqdmlqQWgTTx8TBKdXAJMwikfJpddIbx9ldBefK5II/BQU8j/pUz/Z7
        Mc+9f1OMj73aNz3pmUPDzT3W8eHhrxZ3rjMJ57u1JnRRw1b5+FzWskcZGQKL+RY1Xpx7puF0
        t94jvW3ylxcfEWO6EP/GONTymGKaY0vQ10/2pz9m7lNXb2q8WvPxe2vy3bN8EyyO6BkdEdq1
        b4WYwP09N3b42t0+aDw93M3s81YWB6mec7Es5rsdXWJyt0tuT1pflbJxqWPoMsMl2wuZN3ll
        PjdaHnVu07MGJYl3PiJlEid4l+rI1UdYXPXlVfZ1etTi0Ptxs4XojlkNfV8czJo3RYh0T17W
        Mbn60cEg1WqX6Pjnz7W63cN+3jx7oKxQSqpQiaU4I9FQi7moOBEAKVH7pfMDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230717090324epcas1p3f78e1005a9775015c1b561b446df9cd5
References: <25d422c1ac26f0c59ef10a8a2afe057b@208suo.com>
        <tencent_5D4E47E7BC2D92FC229E6245684D90B2ED06@qq.com>
        <CGME20230717090324epcas1p3f78e1005a9775015c1b561b446df9cd5@epcms1p3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This patch fixes the checkpatch.pl error:
>
>./drivers/extcon/extcon.c:321: ERROR: space required after that ',' 
>(ctx:VxV)
>
>Signed-off-by: maqimei <2433033762@qq.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

@Chanwoo, it looks like that's from a 7 years old commit of yours :).

>---
>  drivers/extcon/extcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>index 6f7a60d..4ef4422 100644
>--- a/drivers/extcon/extcon.c
>+++ b/drivers/extcon/extcon.c
>@@ -318,7 +318,7 @@ static bool is_extcon_property_supported(unsigned 
>int id, unsigned int prop)
>  }
>
>  static int is_extcon_property_capability(struct extcon_dev *edev,
>-                unsigned int id, int index,unsigned int prop)
>+                unsigned int id, int index, unsigned int prop)
>  {
>      struct extcon_cable *cable;
>      int type, ret;
