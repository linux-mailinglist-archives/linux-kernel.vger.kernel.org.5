Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C47CA428
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjJPJ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjJPJ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:29:17 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C8F9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:29:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DAA340004;
        Mon, 16 Oct 2023 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697448553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=roto2Ms7aae9Nrn/EG4m5v2+AAmE4JeuXUIB3zViURE=;
        b=HbNexEedPtyTC7NOct2pfHl6gYY28pnQsEyF+HtbB0qfUwxPdrDe2W3aF1V5WN/xmR2s2j
        F1K6F/sMbcvvbv85k3dyk0YpPVzWP8BlNCdGESM4EToEK2aw22JfiMHZTict3hcfMUkkMg
        KPIjFojVikiwg9ysV77+EQq1W5QCGW0b+le0jy+VzaccvW02/GcIgaK7Z2WC4R4sdAg6j4
        UiRSMYKJFYFnD9bunkaHb35VRbEE1GYWkWIt/eV9W0XNRLKvPPYiGbnPPCCz+2mIYHpJza
        2VHuPtePVMpgBubd25uMZkedPcNzIj3pvjZ1crLdpKBfDJe1p9u93zvcHjjjbQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@salutedevices.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Dhruva Gole <d-gole@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
Date:   Mon, 16 Oct 2023 11:29:11 +0200
Message-Id: <20231016092911.289145-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002140458.147605-1-mmkurbanov@salutedevices.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f447318fb1d156b4b6da79266724c7ee347d1b59'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-02 at 14:04:58 UTC, Martin Kurbanov wrote:
> Add support for FORESEE F35SQA002G SPI NAND.
> Datasheet:
>   https://www.longsys.com/uploads/LM-00006FORESEEF35SQA002GDatasheet_1650183701.pdf
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
