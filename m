Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC77C4E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjJKJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjJKJYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:24:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F491
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:24:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4938C433C8;
        Wed, 11 Oct 2023 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697016283;
        bh=gk4V8UZLKT4DCzpvkyODPILbITWLEGLCVvRKJr63fLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvF/RxImxfRhAyXH/4o3y5Tq8nSj9pJw+v4IGiUuOXvt8hSUDHkE30c/jaOgFcy/6
         x3ZpmxmHeo2J/uHJAVBLJTTbcaIxdzQIjQwmx1FMBvm7bpCRfo7aRSfm97Lh3OEKke
         0hO9lxDg7W0mY7qvGeI92ibCbAa0aYuv2z5qpevo=
Date:   Wed, 11 Oct 2023 11:24:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
Message-ID: <2023101111-acquire-dosage-65c1@gregkh>
References: <20230919224327.29974-1-quic_wcheng@quicinc.com>
 <5f491814-c105-64e3-93c0-5fff89160ac1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f491814-c105-64e3-93c0-5fff89160ac1@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:01:05PM -0700, Wesley Cheng wrote:
> Friendly ping to see if there are any updates/feedback on this patch?

Please do not top-post.

Anyway, did you not see my bot's response to this patch?  If so, why did
you ignore it, that's why we didn't do anything with it...

thanks,

greg k-h
