Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A797DE650
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjKATRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKATRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:17:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EE0A2;
        Wed,  1 Nov 2023 12:17:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A340EC433C8;
        Wed,  1 Nov 2023 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698866252;
        bh=FuUiw8itVAJjkHPvJVVxQcTEuRUyMDOPaLxHMR/IyJs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bD3iQwowjQDcCub2Kuxz3MI5AV7PqFKJ+EvxQ5pbYnXAiepYOyWF4nwFYYzQXXmdF
         doBZJu4VFY2ejAhXPAlzUglc5E6Xj9eiGBM3By13a4yUD7SYUZy5HFpfo0gvy3D9yb
         C1zU61vaboyR6d4Camuveqz8b/nURW4JMoxM4ycahcbExbS9Vp+ZwV5a+feeC9hTkk
         T0k43YsGjyWhmInLNejlq83PC5iwpOJ4TtzTXdp2xcJScfOv9bQ6FkJmKEasnfmGtC
         nr40dJfR++jtJantttAb6FRFjSUpLV5XsrBJ+3PUwOdCU3719RwcdbkwRhTKPLLovr
         /JLYoREIbeRCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 34531CE09BE; Wed,  1 Nov 2023 12:17:32 -0700 (PDT)
Date:   Wed, 1 Nov 2023 12:17:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Yong He <alexyonghe@tencent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <0ad31d6d-363f-4486-ba31-c30d4bb33ac8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231101120121.04919c8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101120121.04919c8d@canb.auug.org.au>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 12:01:21PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   8a77f38bcd28 ("srcu: Only accelerate on enqueue time")
> 
> This is commit
> 
>   1bb2b7de033a ("srcu: Only accelerate on enqueue time")
> 
> in the rcu tree.

That was me being one version behind Frederic's tree.  I updated, and
apologies for the hassle!

							Thanx, Paul
