Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9F78FEA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbjIANvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347787AbjIANvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:51:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B2CFE;
        Fri,  1 Sep 2023 06:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CAEAB82531;
        Fri,  1 Sep 2023 13:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24954C433C8;
        Fri,  1 Sep 2023 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693576290;
        bh=NTVw38G2qVPXTuwzrQPq23tuQlyTYtv68+FUj+uvdNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9YeRsK/BowHDpvqPZbhrU0KFCnAQatb8h99a2O7J6GWv1A0iI8M5+T2HC6RFvFxM
         iZC8RqPp9OTJ4bks15RGbLrwu4Z0xKCFOBk0YEE2FeyhARi7GBXVERfGpmLOj2HcH+
         Mom8hcjzYQkWlZdoFPbPDL7y2DbGFKbyH22G3B8sWspGUY1cBDi9jkFnVWbS/6+/Gi
         XJB2L3dLUgUGG9VjQsK9GxVQRdG9uBZB0o/RCKcTXrtuOZCAVOSgliG+DXYaQqbvjU
         MBR+TP7/ni7jb1J7ptHwbh7DM4ySpITwgPhaw1CRAn5F+uhnVVdEVxpnWGs/sMC/rp
         B7FSNEKTWlUBQ==
Date:   Fri, 1 Sep 2023 15:51:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph/ceph_common: =?utf-8?Q?Re?=
 =?utf-8?B?bW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZ?= values from ret
Message-ID: <20230901135115.GF140739@kernel.org>
References: <20230902185022.3347-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902185022.3347-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 02:50:22AM +0800, Li kunyu wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
