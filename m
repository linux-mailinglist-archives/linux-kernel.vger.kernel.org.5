Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A467B829F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbjJDOqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjJDOqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:46:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE7C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:46:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC5C433C7;
        Wed,  4 Oct 2023 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696430808;
        bh=naCZsxAcYmOPjb1jywP+4alIhYI/eZspEZwVwCeRJys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RXUMxPKWkH7mXUHVPePZPxTKVpW/uFGpZuBvPCS1X9usF9DsC26B7IBb42bp6HPCp
         3dtQYxdntZSHESmPX94jHKCID8FLIOu88QttXc9QMvLr5xQIU4hdnyGlDVFhLrEJ5Q
         82iDnBHMTZRtTATJX0GvIqvM2mz7RtuivvKjiD+2rI/MZz37l8PpSovNWOL6or61gj
         PTd6057XDBNfTESqzbifPMlWRegZNGaTjoszA9nnITYky+HL7Hp1WIjHEucu6CIFwQ
         jUlW/HV1rr4eSwXyDVTP4x8z7ahoRzpJ+GzxW0fA6Ix84sMC8eI2gYrfPmojpvqqwd
         Xed4Jwrk/Coqw==
Date:   Wed, 4 Oct 2023 07:46:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     <esben@geanix.com>, Harini Katakam <harini.katakam@amd.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jsc@umbraculum.org>, <christophe.jaillet@wanadoo.fr>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL
 TEMAC driver
Message-ID: <20231004074646.6fd564a6@kernel.org>
In-Reply-To: <4b8361e5-08f8-4cf8-a277-769647fb9c4c@amd.com>
References: <20230920115047.31345-1-harini.katakam@amd.com>
        <878r8qxsnf.fsf@geanix.com>
        <4b8361e5-08f8-4cf8-a277-769647fb9c4c@amd.com>
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

On Fri, 29 Sep 2023 08:06:46 +0200 Michal Simek wrote:
> > Ok. But while that might mean that no new designs should use LL TEMAC
> > IP, why do we need to declare the driver for it obsolete?
> > 
> > Existing designs using LL TEMAC IP might need to upgrade Linux kernel
> > also.  
> 
> If you want to take responsibility for keeping that driver alive then feel free 
> to send a patch on the top and declare it publicly. We are not able to test it 
> on these old platforms that's why we are publicly saying that it is end of us.

Why Obsolete tho? There's no other driver for this IP, so Orphan sounds
more accurate. Please change it to Orphan.
