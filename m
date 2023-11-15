Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3A7EC447
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjKOOAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbjKOOAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:00:46 -0500
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CC8AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:00:42 -0800 (PST)
Received: from Vostro-3710.lan (unknown [58.61.140.31])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 63E288000B5;
        Wed, 15 Nov 2023 22:00:13 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     miquel.raynal@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 1/1] mtd: rawnand: add support for TH58NYG3S0HBAI4 NAND flash
Date:   Wed, 15 Nov 2023 22:00:09 +0800
Message-Id: <20231115140009.1729640-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114123008.185071-1-amadeus@jmu.edu.cn>
References: <20231114123008.185071-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEtPVkIdT0hKHR0YSB9DTVUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VISllXWRYaDxIVHRRZQVlPS0hVSkxKT05PVUpLS1VKQktLWQY+
X-HM-Tid: 0a8bd3485011b03akuuu63e288000b5
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6Fgw5FzwwA0wKMzECCE9M
        FRMaC0xVSlVKTEtLS05NQ0pPSkNNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VISllXWQgBWUFKSUlONwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

However, the NAND ID of this flash is {0x98, 0xa3, 0x91, 0x26},
the last ID bytes is missing. Maybe this patch should be put in
OpenWrt as a hack.

Thanks,
Chukun

-- 
2.25.1

