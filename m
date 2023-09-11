Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3261279C0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377363AbjIKWV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbjIKQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:00:34 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82961AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:00:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09541C0008;
        Mon, 11 Sep 2023 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694448027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qS38ocazPpEpppEYVtNerL69O277vxu46/4AvalaBdQ=;
        b=a98mjC4nYPsHIUq+qRsYP+aUNFyqgcpwE/HTQ+jIK/d5P7TWa4ezwnCnvVBaj3QNtn90TQ
        7u6WVLs7esTJzRMAEH3vckgGno98cLfnd0YI49Z9aXotLZ7bMgewFibIvwcToPPA2AcaIR
        f9pCXLUNV4f403zFnb+x7hlDWgrBHKOh8LfMN8zezpzXhPC7AlOekZyVtGq8A2PsdLWDtv
        2QoZ5fMpyWAHuYTkURjyzdJpc0No/pCyN+N9ehtaAFKRQmQIwgzvLinPn1wOD/Kh6dh9MS
        bF3JeztQ4OW4bIIZIdBFOa/FPY/OAxckmhZCPxBm5hfKy900tje9D3pMXI4ukw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: remove 'nand_exit_status_op()' prototype
Date:   Mon, 11 Sep 2023 17:59:24 +0200
Message-Id: <20230911155924.764572-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823105235.609069-1-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'48919c6c48380aa1aec4243c7e6ad39e89d78539'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-23 at 10:52:31 UTC, Arseniy Krasnov wrote:
> This function is exported and its prototype is already placed in
> include/linux/mtd/rawnand.h.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
