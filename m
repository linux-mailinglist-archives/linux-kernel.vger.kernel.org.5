Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A67AADAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjIVJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:19:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377B99;
        Fri, 22 Sep 2023 02:19:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBE5C433C7;
        Fri, 22 Sep 2023 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695374369;
        bh=MGRXnYg29PMwD6qHNsbP5TV5bNVbXhBCYQoDPIAa8qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vaWfp18/X7gilRslJD1MI/VHTPcdGziKsMJALZP6jo+S8MiwkjzZjAK2qH8gYFbyd
         bwTTHZpOATXAOOzBsecNfBWxAuEPUSiebBhsc/kLgJ3xuNGESx4dNenr3m76CayRFC
         LZVR20KqbFBd1o6WveLoQqwrYC0AFx1iPe74IN4k=
Date:   Fri, 22 Sep 2023 11:19:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: 8250: Add more support for and fix up
 Brainboxes cards
Message-ID: <2023092216-outcome-police-4a79@gregkh>
References: <DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <2023092134-wizard-nintendo-9b74@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023092134-wizard-nintendo-9b74@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:29:14PM +0200, Greg KH wrote:
> On Thu, Sep 21, 2023 at 10:13:33PM +0100, Cameron Williams wrote:
> > Add support for the rest of the Brainboxes range of serial cards,
> > except the 3-port variants as there is no suitable configuration
> > in this driver.
> > 
> > - The pci_ids.h file has been updated to define each card's ID, cleaner
> > than using the raw ID.
> 
> That's not happening in this patch, are you sure you got this correct?

And where are patches 1-3 of this series?

thanks,

greg k-h
