Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7C7D07DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbjJTFxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjJTFxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:53:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3356CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1446C433C7;
        Fri, 20 Oct 2023 05:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697781219;
        bh=5H6AkLY3cuSxz+5a35NJwToZCCQZU07uOZ4SXH046HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5fb2/+wglgG+GujFpFY+Fr3eULWoMihOFvMwEgOXOZXMm1YWOAgfVOK2B4zwW/UR
         zAcU32NNhq2rUc4DuuFuYKvlZssG4HFHZeZetUX3f6x/7qXgCDZ1rHDxEdo+e/OVqN
         y57MjX41wxUz2GrwvdnqQEbhvzlzHa0CRBKLp6qI=
Date:   Fri, 20 Oct 2023 07:53:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.6-rc7
Message-ID: <2023102029-channel-woven-6e61@gregkh>
References: <ZTFC1jhZ0m5PIMRE@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFC1jhZ0m5PIMRE@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:53:10PM +0200, Johan Hovold wrote:
> The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:
> 
>   Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.6-rc7

Pulled and pushed out, thanks.

greg k-h
