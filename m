Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E677F7904
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKXQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:31:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1F11BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:31:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BD9C433C7;
        Fri, 24 Nov 2023 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700843511;
        bh=pfvOZV8p3wu114D/yxIF+Nyr/Ey/SQWXpaDJFR4ILP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPdx0RSywCULJ6JmMsV3bbedW4tUqI53GSP8Ou2RJkRiOsMxtP6qa1+El1D6Z9+Ug
         o+wBDQcizUh7KgGfsK1COlQubTOj25amw5Fr15NlcQbl9oJzbpbY34sH9VIK13caeD
         ftnjGuVt/y03mVZDee9Mzjp1RnBeLgvvWkSEQYqY=
Date:   Fri, 24 Nov 2023 16:31:48 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.7-rc3
Message-ID: <2023112441-directed-reverence-ae19@gregkh>
References: <ZWB3zPa1o74IfDM5@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWB3zPa1o74IfDM5@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:15:40AM +0100, Johan Hovold wrote:
> The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:
> 
>   Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.7-rc3

Pulled and pushed out, thanks.

greg k-h
