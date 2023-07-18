Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B898758390
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGRRe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354D91;
        Tue, 18 Jul 2023 10:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50AB616A0;
        Tue, 18 Jul 2023 17:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D933C433C8;
        Tue, 18 Jul 2023 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689701692;
        bh=gRqK4YQ9SwmOtiWj1frwDfFvpy6S6QoNvpMI5EL4rP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKdno7EYrnRrGF6BIgpk6wjGWU5SJFWTnoWdbXbJqtegpdQhERHFWu/+CmJ6V31I6
         ZTFvr4dy4oZ8UQjpG4TANXYe+0M6fyGPQeYsaKTnErBBelTlVsLIzGyANsRY/a8Y5c
         V4ng2bwJrRBuehzaCh/I2Lzvwkdy26E2cC1A/hBk=
Date:   Tue, 18 Jul 2023 19:34:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, broonie@kernel.org,
        krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <2023071832-headstone-chafe-5be9@gregkh>
References: <20230718155814.1674087-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 08:58:14AM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Looks good to me, thanks for writing this up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
