Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51F800434
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377649AbjLAG4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:56:36 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73589171A;
        Thu, 30 Nov 2023 22:56:43 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 6350860476;
        Fri,  1 Dec 2023 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701413803;
        bh=rCfSlTTMt0AuaLRhIg405pBsrNHK2Y5VgYH9Y2Qiidc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/lgqMkVXbMwcGYRzC7DRMWC2iwx0bpoILYJoeeuUrAbiQjpfPCwpELNZykmOLIgL
         Pwfl02dwxt5Ud7Nf8Le3YOeXWwQIwOgAc8InlHvtn9jPh70yjSu9fJwPRlJ642u2Nx
         PcT9nM1G8lgarwtxLdf6FpdEQHDnKG7W/+IprlLYC4bDpmt0iewgsW8hXwcUdia29l
         a4rQe5dU9DbSEMz8pjNEoalD0S0FN3udCG7/XdXoWH42IhD8ZXc+kg6gj+5fK8Ya/h
         JmSEXcSIk401izJKzStII4aZ7fw4SD3X9cjqnDW37ZJMpiHD0MU5UC8GTrryA/YQ/4
         c46Y7onyOdyAA==
Date:   Fri, 1 Dec 2023 08:56:32 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add omap bus drivers to OMAP2+ SUPPORT
Message-ID: <20231201065632.GH5169@atomide.com>
References: <20231115104434.25796-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115104434.25796-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [231115 12:44]:
> While doing some code cleanup in drivers/bus/, I noticed that the files
> drivers/bus/omap*.[ch] have no maintainer.
> 
> As far as I see from the git history, important changes to those files went
> through Tony Lindgren. Further, the inclusion of those drivers depend on
> the config ARCH_OMAP2PLUS being enabled. This suggests these drivers are
> part of the section OMAP2+ SUPPORT.
> 
> Add the omap bus drivers to OMAP2+ SUPPORT.

Applying into omap-for-v6.8/maintainers thanks.

Tony
