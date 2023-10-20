Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAE7D16C8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJTUH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjJTUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:07:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA13D52
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:07:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC166C433C7;
        Fri, 20 Oct 2023 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697832474;
        bh=6p/iT1gidGXAi7ufrWiP8Qwl+JI67lYMgyF7ejAlI68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJ+PgX3btaN69zQBT+FRSPGeztNkf4ZBj1oGHks16wvipw2YqJGnZv7DuAQgrV052
         3aFqvGZB44LQbKYIPvadWJW9fA5yFiG9CpnRy1vR9QiGqsvo6ShdXlUhyNDK7AEuYw
         6T5l0k4QYczx6VUHUtv7SzD8rg1pOOYZudyhJaNE=
Date:   Fri, 20 Oct 2023 22:07:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: Dual licensing [was: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc
 driver]
Message-ID: <2023102043-sauciness-encrypt-48c3@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
 <20231018185629.GD3952@nvidia.com>
 <2023101913-owl-showman-5858@gregkh>
 <87r0lq8eop.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0lq8eop.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:50:30PM -0600, Jonathan Corbet wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > For your new files, please make them single license.  If you insist on
> > dual licensing them, I will insist on have a lawyer sign off on them so
> > that they understand the issues involved with dual licenses, and just
> > how much I hate them in the kernel tree as they are a pain over time.
> 
> Out of curiosity, is there somewhere people can look for a description
> of these issues and the pain they cause?  I've seen this go by enough
> times to think that it would be good to set down in Documentation/
> somewhere for future reference.

I don't have a description anywhere, sorry, this was just discussions
with many open source lawyers who focus on the kernel over the years.
I'll work to try to get something "solid" from them that I can put into
writing, but it will probably take quite a while...

thanks,

greg k-h
