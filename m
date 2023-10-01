Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754F57B4975
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjJATrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjJATre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:47:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E0C4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 12:47:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6754BC433C8;
        Sun,  1 Oct 2023 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696189651;
        bh=DN2hN7meQ6DYGeJl4taTidBevp+JrcBNFzPmwT2iE3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdnwntEU9MEecMilBq7ZCfkcEiuJ7V+6vRkRT/Vgp4WRYzzfq02Xio8zh8mugnpdx
         e3Fyn4EFSvWDW1GdZ1/JhhXO0gWluaO652t3hAMrxi9u/xLpy42JhFTXTKpr6XnCww
         xKOSyPe5ZmH9XrOPBzBYx0CzVXcZNh/KZ4+rB4MUSXW8qu7br9iUULdaWW+3hgPPqM
         +/3DvyHHDS/sSiDosXVFnJbD/qWCJUdemvojuJTk/VHRsRRb/aDO+rcru0su77gKF4
         oHt2yAK/uAiuB8VXkktHVDowcBuR5eq9NtYNAMsGD6+Q9XcO8txOupheH6ziFodHei
         jxnUXLEAU+ILA==
Date:   Sun, 1 Oct 2023 21:47:03 +0200
From:   Simon Horman <horms@kernel.org>
To:     chenguohua@jari.cn
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: Clean up errors in atm_tcp.h
Message-ID: <20231001194533.GW92317@kernel.org>
References: <32b04d0b.86a.18ad54f1174.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b04d0b.86a.18ad54f1174.Coremail.chenguohua@jari.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:24:03PM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required after that ',' (ctx:VxV)
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

Hi GuoHua Cheng,

unfortunately, patches that only contain checkpatch clean-ups
for Networking code are not accepted.

pw-bot: rejected
