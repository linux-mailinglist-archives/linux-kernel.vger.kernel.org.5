Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C387DE19C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344121AbjKANT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343851AbjKANT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:19:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB63A102;
        Wed,  1 Nov 2023 06:19:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A34FC433C9;
        Wed,  1 Nov 2023 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698844794;
        bh=wMsbiq8mxqi0Aabju/Zt8NFoQfuizV+q9reXZUKkN6E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EXWkWN6Fk7+PdfzDVy32SEf56gXKxDiiv4aANU0kF4uSc6SCEhF2mLHMzSkI1d9L8
         iSy5CpimTCetbBXXNaXOqOPcToCfK+C2tPwLJyKY7HJnRa+DRFDI6YQC4dNPVDRp8A
         /T8/E95IUhq+DwMNoJxDGO03dhzoz0z/4yzk4+FTDpWlgnW+iRqrEHtbwREOhhQTYe
         2wUJKw9YfqCz6CEJzgLWMRmgApmDAQHFF90p/b8Lses1IgF3pSM3c1mnoeGMhipd8n
         +P4TQnJCjH99VO6tmncCPN926QGM6zw4PBsJPkSSz6e8lhB0iXyZLMYNPR/ES+Lz+j
         /mFgicj2XqzSA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tom Waldron <tom@baremetal.dev>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] wifi: mt76: mt7921: Add a new VID/PID 0b48/7922 for
 MT7922
References: <20231101095533.45258-1-tom@baremetal.dev>
Date:   Wed, 01 Nov 2023 15:19:51 +0200
In-Reply-To: <20231101095533.45258-1-tom@baremetal.dev> (Tom Waldron's message
        of "Wed, 1 Nov 2023 09:55:33 +0000")
Message-ID: <87o7gdbog8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Waldron <tom@baremetal.dev> writes:

> Add VID/PID 0b48/7922 for MediaTek MT7922 wifi chip.
> Change tested on Redmi Book Pro 15 2023 (Fedora 38).
>
> Signed-off-by: Tom Waldron <tom@baremetal.dev>

Should I take this to wireless? Felix&Lorenzo, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
