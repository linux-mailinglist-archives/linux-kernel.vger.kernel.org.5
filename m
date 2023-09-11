Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9B79B8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbjIKWUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbjIKTCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:02:41 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F5D8;
        Mon, 11 Sep 2023 12:02:34 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qfmAg-0000w8-1z;
        Mon, 11 Sep 2023 19:02:06 +0000
Date:   Mon, 11 Sep 2023 20:01:57 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: mtd: add basic bindings for UBI
Message-ID: <ZP9kJYHMFwZ8GFnA@makrotopia.org>
References: <cover.1691717480.git.daniel@makrotopia.org>
 <a640bb10e6fbaeef96efdb9e8b666ca39e993589.1691717480.git.daniel@makrotopia.org>
 <169263908218.2000617.16931192155432403196.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169263908218.2000617.16931192155432403196.robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:31:22PM -0500, Rob Herring wrote:
> On Fri, 11 Aug 2023 02:36:37 +0100, Daniel Golle wrote:
> > Add basic bindings for UBI devices and volumes.
> > 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Patch 3 - 7 have previously been discussed on the mailing list, patch
1 and 2 have been reviewed by Rob, patch 8 ("mtd: ubi: provide NVMEM
layer over UBI volumes") still needs review.

Is there anything I can do from my end to have this series moving
forward?

Patchwork: https://patchwork.ozlabs.org/project/linux-mtd/list/?series=368347


Thank you for your advise!


Daniel
