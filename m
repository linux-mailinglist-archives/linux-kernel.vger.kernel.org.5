Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF479ACC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbjIKU5O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbjIKTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:10:37 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E46DDD;
        Mon, 11 Sep 2023 12:10:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 616D0635DB56;
        Mon, 11 Sep 2023 21:10:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BhVzL38_nvWl; Mon, 11 Sep 2023 21:10:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 68B35635DB5A;
        Mon, 11 Sep 2023 21:10:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id am1q5NFYuOSv; Mon, 11 Sep 2023 21:10:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3DA8F635DB56;
        Mon, 11 Sep 2023 21:10:28 +0200 (CEST)
Date:   Mon, 11 Sep 2023 21:10:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        chengzhihao1 <chengzhihao1@huawei.com>, robh <robh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1097004835.16854.1694459428036.JavaMail.zimbra@nod.at>
In-Reply-To: <ZP9kJYHMFwZ8GFnA@makrotopia.org>
References: <cover.1691717480.git.daniel@makrotopia.org> <a640bb10e6fbaeef96efdb9e8b666ca39e993589.1691717480.git.daniel@makrotopia.org> <169263908218.2000617.16931192155432403196.robh@kernel.org> <ZP9kJYHMFwZ8GFnA@makrotopia.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: mtd: add basic bindings for UBI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: dt-bindings: mtd: add basic bindings for UBI
Thread-Index: LBx3qjf2tbmBuBCvCWOgaQQSzR540w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> An: "linux-mtd" <linux-mtd@lists.infradead.org>
> CC: "chengzhihao1" <chengzhihao1@huawei.com>, "robh" <robh@kernel.org>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Randy
> Dunlap" <rdunlap@infradead.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "devicetree"
> <devicetree@vger.kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
> <conor+dt@kernel.org>, "Rob Herring" <robh+dt@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 11. September 2023 21:01:57
> Betreff: Re: [PATCH v4 1/8] dt-bindings: mtd: add basic bindings for UBI

> On Mon, Aug 21, 2023 at 12:31:22PM -0500, Rob Herring wrote:
>> On Fri, 11 Aug 2023 02:36:37 +0100, Daniel Golle wrote:
>> > Add basic bindings for UBI devices and volumes.
>> > 
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> 
> 
> Patch 3 - 7 have previously been discussed on the mailing list, patch
> 1 and 2 have been reviewed by Rob, patch 8 ("mtd: ubi: provide NVMEM
> layer over UBI volumes") still needs review.
> 
> Is there anything I can do from my end to have this series moving
> forward?
> 
> Patchwork: https://patchwork.ozlabs.org/project/linux-mtd/list/?series=368347

It is on my review TODO.

Thanks for your patience,
//richard
