Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E17DAB57
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJ2HUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2HUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:20:47 -0400
Received: from mail-m25489.xmail.ntesmail.com (mail-m25489.xmail.ntesmail.com [103.129.254.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62709D3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 00:20:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.61.140.248])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 37C2F800084;
        Sun, 29 Oct 2023 15:20:11 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     miquel.raynal@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 1/1] mtd: rawnand: add support for TH58NYG3S0HBAI4 NAND flash
Date:   Sun, 29 Oct 2023 15:20:05 +0800
Message-Id: <20231029072005.6097-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023095451.65c4c0ec@xps-13>
References: <20231023095451.65c4c0ec@xps-13>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0oaVkNCGkNKGEpPGExLTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VJT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b7a4df592b03akuuu37c2f800084
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6Mhw*SDw9ISlIPhpWOBMa
        CCkwFBpVSlVKTUJDTk1PS0pJS05KVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VJT0NZV1kIAVlBSkpMTjcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

> Any way you can detect this and fix the parameter page at run time
> instead?

Sorry but I don't know, I know very little about this.

Thanks,
Chukun

-- 
2.25.1

