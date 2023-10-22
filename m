Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B027D2209
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 11:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJVJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 05:18:45 -0400
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Oct 2023 02:18:40 PDT
Received: from mail-m25489.xmail.ntesmail.com (mail-m25489.xmail.ntesmail.com [103.129.254.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB1CC;
        Sun, 22 Oct 2023 02:18:40 -0700 (PDT)
Received: from Vostro-3710.lan (unknown [58.61.140.248])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id DE71580003D;
        Sun, 22 Oct 2023 17:09:04 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     kvalo@kernel.org
Cc:     pkshih@realtek.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: RE: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
Date:   Sun, 22 Oct 2023 17:09:01 +0800
Message-Id: <20231022090901.430143-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8734yff8vr.fsf@kernel.org>
References: <8734yff8vr.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSxlIVh0YQ0JCQkxJS0wZS1UTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VJT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b56a52398b03akuuude71580003d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46DBw*Ejw9DEIYME0XAi4#
        Dy5PCR1VSlVKTUJMQk1OTE9OTkhNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VJT0NZV1kIAVlBSkhJSzcG
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> _Why_ is that warning printed? Are your devices uncalibrated or are they
> somehow else special?

I don't know, but not only my rtl8822be wifi module will have this call trace
every time when the driver probes. This can be considered a common problem.
So I prefer to disable this call trace and use the driver warning instead.

Thanks,
Chukun

-- 
2.25.1

