Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B817B2C30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjI2GIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjI2GIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:08:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A27D1A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:08:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F0AC433C8;
        Fri, 29 Sep 2023 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695967710;
        bh=NxhqwjqXSx2IRv90dOqMDGtsbuVUkiqgi/rEjSYcbV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y358pZkfSOyYzle+DggaDCprDnI2elqrdM5IbiuRYjSE4x7UXSIUEpMdtBye/Zajs
         OueWBSFE5x2oFaD9x6OYjzxSO9wb1KAmVXhbg3d4O8+HN52NZXy7ic/60oM69jG0Vw
         3roLp5OerqrL+cpEcmvIyBmqmzC4ozVOXRmjx7d0=
Date:   Fri, 29 Sep 2023 08:08:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
        Russ Weight <russ.weight@linux.dev>
Subject: Re: [PATCH 1/3] firmware_loader: Update contact emails for ABI docs
Message-ID: <2023092953-venomous-upswing-f8fe@gregkh>
References: <20230928164623.278570-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928164623.278570-1-russell.h.weight@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 09:46:23AM -0700, Russ Weight wrote:
> Update the firmware_loader documentation and corresponding section
> in the MAINTAINERs file with a new email address.
> 
> Signed-off-by: Russ Weight <russ.weight@linux.dev>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>

You're the same person, no need to sign off twice on it, just do so once
from your intel account.

thanks,

greg k-h
