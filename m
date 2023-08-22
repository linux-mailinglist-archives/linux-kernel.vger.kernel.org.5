Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA47840EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjHVMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHVMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788EA196;
        Tue, 22 Aug 2023 05:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CFBC615BE;
        Tue, 22 Aug 2023 12:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA661C433C8;
        Tue, 22 Aug 2023 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692707891;
        bh=Zgls8mquklkoOzDorcp2aKAcyrdPbOZyAYNdvU/uPis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2AO5nToyYcEsaAwLXznbuD5uFB25F7VFLfvwfg4+SHeJzUq4NrPFTrmzPx3JWUH+
         ElP0ARg9Wra0zx9YgAuQVLrB3ElIhmxVDDaYAVFzjbi++5xLDk8iLSvKAdDnn3+Gn3
         FEZB6fL8r9drcNLWFza/zvycr9bhR5fzpMEatfAY=
Date:   Tue, 22 Aug 2023 14:38:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: set initial svdm version based on
 pd revision
Message-ID: <2023082231-strode-pretty-f5a3@gregkh>
References: <20230731165926.1815338-1-rdbabiera@google.com>
 <CALzBnUFH=eQmhdpkt5_czKsZ22=u6yDoZZ0TX4eJkHGbjLANAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzBnUFH=eQmhdpkt5_czKsZ22=u6yDoZZ0TX4eJkHGbjLANAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:09:14AM -0700, RD Babiera wrote:
> Hello,
> 
> Just wanted to ping this patch for review in case it got lost/forgotten about.

What patch?

And note, people were on vacation.  If can, to help your patch get to
the front of the review queue, please review other typec patches on the
mailing list.

thanks,

greg k-h
