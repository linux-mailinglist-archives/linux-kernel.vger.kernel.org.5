Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5727C5867
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjJKPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjJKPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:45:33 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C4D9D;
        Wed, 11 Oct 2023 08:45:29 -0700 (PDT)
Received: from p5dcc3baf.dip0.t-ipconnect.de ([93.204.59.175] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qqbOW-004kuE-QU; Wed, 11 Oct 2023 17:45:08 +0200
Date:   Wed, 11 Oct 2023 17:45:06 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     dmitry.torokhov@gmail.com, Jonathan.Cameron@huawei.com,
        robh@kernel.org, frank.li@vivo.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [RFC PATCH] Input: omap4-keypad: react on keypresses if device
 is runtime-suspended
Message-ID: <20231011174506.734133ae@aktux>
In-Reply-To: <20231011100726.GD34982@atomide.com>
References: <20230929200046.2300333-1-andreas@kemnade.info>
        <20231011100726.GD34982@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 13:07:26 +0300
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * Andreas Kemnade <andreas@kemnade.info> [230929 23:01]:
> > According to SWPU235AB, table 26-6, fclk is required to generate events
> > at least on OMAP4460, so keep fclk enabled all the time the device
> > is opened.  
> 
> Sorry for the delay, the patch looks good to me:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> 
So with all open questions resolved, this can be treated as
s/RFC //

Regards,
Andreas
