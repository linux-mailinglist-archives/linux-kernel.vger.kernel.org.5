Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5B7D60B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjJYEBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjJYEBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:01:32 -0400
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4945D137;
        Tue, 24 Oct 2023 21:01:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.61.140.248])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 8B0078000C1;
        Wed, 25 Oct 2023 12:01:05 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
Date:   Wed, 25 Oct 2023 12:01:00 +0800
Message-Id: <20231025040101.17919-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8dffe5f57c6948e1bca5f7cb3e40a781@realtek.com>
References: <8dffe5f57c6948e1bca5f7cb3e40a781@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTBhDVhpNGBgfQhkYHh8ZSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VJT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b64fe3ecdb03akuuu8b0078000c1
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6EBw4Ezw3NTM8FhYITAw4
        IxMwCwpVSlVKTUJDSUtNT01NSEtNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VJT0NZV1kIAVlBSk5NTTcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Except to call trace, rtl8822be works well in your side? If so, you just
> worry the verbose trace, right?  

Yes, it's a bit noisy.

> By the way, I tested two hardware version of rtl8822be, and they both are fine.

Sorry wasted your time, but can you test the rtl8812bu wifi module?
Based on the issues search, I'm not the only one who has this problem.
https://github.com/lwfinger/rtw88/issues/111#issuecomment-1385923235
https://github.com/lwfinger/rtw88/issues/151#issuecomment-1753011363

Thanks,
Chukun

-- 
2.25.1

