Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAF7D4520
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjJXBtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXBtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:49:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34BAD68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:49:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FC4C433C7;
        Tue, 24 Oct 2023 01:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698112188;
        bh=7zvbU5oTPviUOA6ufHc9x4JMbBU8iZUomlQ0VXXYxBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYXbKlTimeuOOFjyCDrgymhd/Ju1hdDh/telqutkknVJ2tWytBqnMUWbp1XUDSNM9
         iZP5dC5MKFNM3qLa4PUwHuuXey99/EhGptt0P9cnQmj6AWVVvXO25A3Lj0sobdWmCl
         uDyrn3YwGXpQ61zVV1Ck8EjoLWXlJTbo51vgn/n5tTh2dmlk2lvsYpgLsv2FrNVZQQ
         DanXZjYnT9KTR8LsDOWCbXISTMeqP9mgZj80UuuPJRxNWCznqvcIQ02rKqeDuxkG//
         llXUh8+LbEygnEg4ddqz/CCNFdRvfHdBAThm00sIe/bSa5ROXs9kD7G9ec9VA02WCI
         W0dit2sV4Db7w==
Date:   Mon, 23 Oct 2023 18:49:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
        syzbot+9704e6f099d952508943@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, wojciech.drewek@intel.com
Subject: Re: [PATCH net] ptp: ptp_read should not release queue
Message-ID: <20231023184947.540eccab@kernel.org>
In-Reply-To: <20231024003457.1096214-2-twuufnxlz@gmail.com>
References: <20231023093334.3d6cda24@kernel.org>
        <20231024003457.1096214-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 08:34:58 +0800 Edward AD wrote:
> > We need a legal name for the signoff, not initials.  
> You may have some misunderstandings about my name, AD is not an acronym. 
> This is my full and legal name 'Edward AD'.

Is there any public person with the surname 'AD' you can point me to?
Or any reference that would educate me about it?
