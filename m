Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1C7A5AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjISHVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjISHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:21:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9310F;
        Tue, 19 Sep 2023 00:21:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD47C43391;
        Tue, 19 Sep 2023 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695108101;
        bh=vipQm+ipmzA33o/tVXoUQOyoIDyB3vzAvg4BjLAMbEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmsRAu2kb27aX+XIX35tWhi4BzSNGCSrLBvou6vyxgMuf32dc9g98LSk6zickJO+G
         oGkXXpFYZhEBuAt0iDNTb3YFOeG2Oka69yhTMZLcU92WYBJPKD4YIjek8+v/fdvqWl
         EbL9wKwWM1kdUgIKZf0quXZ8cVLnvfpNvFKBi6xM=
Date:   Tue, 19 Sep 2023 09:21:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] device property: Clarify usage scope of some
 struct fwnode_handle members
Message-ID: <2023091924-probable-rural-77f2@gregkh>
References: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
 <ZQiCC9xoCzwc/nEd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQiCC9xoCzwc/nEd@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:59:55PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 04, 2023 at 01:40:46PM +0300, Andy Shevchenko wrote:
> > Most of the struct fwnode_handle members are for exclusive use with
> > device links framework. Clarify this by adding a respective comment.
> 
> Thank you, folks, for the review. Rafael, Greg, who can apply this?

I will, give me some time to catch up with my pending patch queue.

greg k-h
