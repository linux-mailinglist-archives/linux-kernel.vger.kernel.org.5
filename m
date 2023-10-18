Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800067CDD66
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjJRNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbjJRNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:34:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F8995;
        Wed, 18 Oct 2023 06:34:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0517BC433C7;
        Wed, 18 Oct 2023 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697636091;
        bh=Rq2cOVDBo17XkfhjMGsdKBrUyF9FZ+SmjBev0mslJE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ocx+MGtLk8zpMddGnte7egNBBxJ6vo9+J+RLevkOfXxaZcpWv23SDdpyE44MuZhxm
         UR44VVj8Ms9DQw8MG7xfGhgKMq5El+7XfUY0F3QlY3Fg2id8tBu/g1Y233tTsaIvZR
         eYbUL+v5cCnK8hsmJTldZsEoRJgcwVt07sI1+oqc=
Date:   Wed, 18 Oct 2023 15:34:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Eckert.Florian@googlemail.com,
        pavel@ucw.cz, lee@kernel.org, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tty: whitespaces in descriptions corrected by
 replacing tabs with spaces.
Message-ID: <2023101817-kissable-fondue-6294@gregkh>
References: <20231016071332.597654-1-fe@dev.tdt.de>
 <20231016071332.597654-2-fe@dev.tdt.de>
 <31ec59fb-4bcf-4c70-996a-ea67b4bfcd2b@kernel.org>
 <fb73fa183cf6619e042273db091056bd@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb73fa183cf6619e042273db091056bd@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:56:38PM +0200, Florian Eckert wrote:
> 
> On 2023-10-16 14:32, Jiri Slaby wrote:
> > On 16. 10. 23, 9:13, Florian Eckert wrote:
> > > Tabs were used in the function description, to make this look more
> > > uniform, the tabs were replaced by spaces where necessary.
> > > 
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > 
> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> Thanks for the review and adding your 'Reviewed-by:'.
> Will add this to the v4 if I get feedback form the led
> subsystem maintainers, if my change to ledtrig-tty are
> correct. So this could get into for-led-next [1]
> maintained by Lee Jones <lee@kernel.org>

You need to redo this patch series anyway, there was comments that one
of these was not needed (or incorrect) so please fix up and send a new
series.

thanks,

greg k-h
