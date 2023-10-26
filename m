Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862157D7A27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjJZB1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZB1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:27:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C439BD;
        Wed, 25 Oct 2023 18:27:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF65C433C8;
        Thu, 26 Oct 2023 01:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698283670;
        bh=MYDUnsiElyxN8jg/XOjZrR5F22XrepJGjxLyE0dqysY=;
        h=From:To:Cc:Subject:Date:From;
        b=dJmop0USTk5foVgmvxw1y8Jc2z9sd0GVeD5iZR66Vb8wZ/Lx/yf5hpYcCDKrZJL24
         NzxWf1YaOT0sTqG3GKsS1m9Bj48/37LpaTVGra8Xtv14k1kbs0zwD8DQSS3JxXAH9V
         OxAu5EMbhx4dKX+D64lLvi8N5zznkBYtzyj5zXGBGzEC+zbh+6x52C20044/iHuk8k
         ShfaNKwa86tJS3Rkw2uTC6OgoDrCHmaL03/gWFexKmaDc9ea1/m2A3rfI3366CkkWz
         TnAuAeJF7rp8zVWuDUcnuTeoSlsOwP2BTaQTsIkpDCk1vn8gHhJdvIvUu0b3UUZZII
         ToYFil0l2jSjg==
Message-ID: <fb12cab33d27c582125a22390e9c3b12.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   Stephen Boyd <sboyd@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     <linux-next@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Add spmi tree to linux-next
Date:   Wed, 25 Oct 2023 18:27:48 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Can you add the spmi-next branch of my spmi tree to linux-next? I
collect patches in this branch and then email them to Gregkh to be
applied to the driver tree. I don't send pull requests.

https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git spmi-next

Thanks,
Stephen
