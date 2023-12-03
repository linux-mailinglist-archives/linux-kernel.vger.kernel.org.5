Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABC8025FE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjLCRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCRaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE1CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:30:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99154C433C7;
        Sun,  3 Dec 2023 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701624618;
        bh=icVOkA4ZruYQ28o6dqOjvQ4T2dTFZfkpGqbWRS9fM4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cECRBRCZ/rVTGXQpq2pwS5nJ4DfYoHbjJ9HpEt8PSD049rinkl2OMHXLrqCMZj+an
         aIAT02zRJHE9Q2DkIotcE8ZOrnzx8+ar4+4/iTMwcp9jPCUMWjW8ISIb/4mWtHezn+
         i7RaxFZixob4q0hSAC9wZXmuLDToEBQR1yVg/p44=
Date:   Sun, 3 Dec 2023 18:30:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Wasim Khan <wasim.khan@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <2023120354-expansion-frequency-f991@gregkh>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
 <2023113014-preflight-roundish-d796@gregkh>
 <20231203151654.nh4ta7vtzwpwg4ss@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203151654.nh4ta7vtzwpwg4ss@skbuf>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 05:16:54PM +0200, Vladimir Oltean wrote:
> On Thu, Nov 30, 2023 at 11:10:19AM +0000, Greg Kroah-Hartman wrote:
> > > Why would we remove name of the current company and use the name of a
> > > company that doesn't exist any more?
> > 
> > Yes, this seems very odd.  What is the reason for any of this other than
> > marketing?  Kernel code doesn't do marketing :)
> 
> I'm not sure who is doing the marketing; not me, that's for sure.
> The patch that I'm proposing undoes these strange aliases.

Why?  Who did it originally in what commit id and what was wrong with
them then?

thanks,

greg k-h
