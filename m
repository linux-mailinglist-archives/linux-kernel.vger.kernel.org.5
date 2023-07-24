Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DF675F9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGXO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ADF10D5;
        Mon, 24 Jul 2023 07:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C90611FC;
        Mon, 24 Jul 2023 14:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A29C433C7;
        Mon, 24 Jul 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690208777;
        bh=UsuBymQjjwxsRq95yzb1Fek+bWa7LNbYsm7DLSXx8Ic=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=coq+CCeVPiX+ezURnrjukdgJBBwFZ/yeTLi+AAVs5XQdPlztP1yyiT3r64xy3y2oJ
         BXguLHAqBKNf+C3G6+/0XucU/C67nI8dPMm6wuH0l46M9c71VQ+WgF9wZ2OSQce1N/
         YZssAtihCnHRuQmPznGTji09eABh6dIjzIGr6n8wMN/2mMTshxAgCOsNTEkHJn4BKH
         HQoFdZSgdj/HbdW9pwUyAzRxUVxtSZ1nC1d7IQo9C2XFXCmhmPGdtv4bmoY/SKVin4
         4OpijgGNlNTdx8dCkWWdG9RxLyOHVCoQyuF/z9FJCkp888LID9ampaakJ3ay1b3zpJ
         umNBDbbfsickA==
From:   Kalle Valo <kvalo@kernel.org>
To:     hanyu001@208suo.com
Cc:     libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libertas: debugfs: Added missing spaces
References: <tencent_0EA6836B1E10A9623158112DD43D48C95605@qq.com>
        <013fa54eeb505b6a7080c6d4ccc3a445@208suo.com>
Date:   Mon, 24 Jul 2023 17:26:14 +0300
In-Reply-To: <013fa54eeb505b6a7080c6d4ccc3a445@208suo.com> (hanyu's message of
        "Wed, 19 Jul 2023 17:31:51 +0800")
Message-ID: <874jlt2xo9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hanyu001@208suo.com writes:

> Fixes the following checkpatch errors:
>
> ./drivers/net/wireless/marvell/libertas/debugfs.c:712: ERROR: spaces
> required around that '=' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:712: ERROR: spaces
> required around that '<' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:723: ERROR: spaces
> required around that '=' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:723: ERROR: spaces
> required around that '<' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:734: ERROR: spaces
> required around that '=' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:734: ERROR: spaces
> required around that '<' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:754: ERROR: spaces
> required around that '=' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:754: ERROR: spaces
> required around that '<' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:754: ERROR: space
> required before the open parenthesis '('
> ./drivers/net/wireless/marvell/libertas/debugfs.c:759: ERROR: spaces
> required around that '=' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:759: ERROR: spaces
> required around that '<' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:759: ERROR: space
> required before the open parenthesis '('
> ./drivers/net/wireless/marvell/libertas/debugfs.c:766: ERROR: spaces
> required around that '=' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:766: ERROR: spaces
> required around that '<' (ctx:VxV)
> ./drivers/net/wireless/marvell/libertas/debugfs.c:766: ERROR: space
> required before the open parenthesis '('
>
> Signed-off-by: Yu Han <hanyu001@208suo.com>

Please don't submit checkpatch fixes to linux-wireless, they are too
much work with very little gain. And libertas is an orphaned driver, we
want to make the absolute minimal changes to it.

I'm now going to silently reject all checkpatch patches in patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
