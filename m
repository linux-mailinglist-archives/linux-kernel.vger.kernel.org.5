Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF07BA338
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjJEPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjJEPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7356079C;
        Thu,  5 Oct 2023 07:07:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5974C07615;
        Thu,  5 Oct 2023 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696493325;
        bh=qLeVgfgZJEmrFma/amtkhUpxRQ1srUhrQuDmfTF5dUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVTL7e04co6xgBFeCLv7WoOknxhJ1Ks5e5DCxjIU62hXA/l9T/sQ5s8ldyUXhhBmO
         l0H6YhiAicGHXUvnZ9kYgHBFylrMYSCgvaO7Ku9KHELyrVNX8nu0XE77Qo3m8QMzVJ
         Jb7MiEg9ShKeZV024Q7pJ/hPVyB9D1sCkeQv6/kM=
Date:   Thu, 5 Oct 2023 10:08:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeongtae Park <jtp.park@samsung.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [PATCH v2 0/7] cxl: Fix checkpatch issues
Message-ID: <2023100506-arena-sip-e5da@gregkh>
References: <CGME20230922113157epcas2p212c253d8fe4f6935ee5cbe284254cc68@epcas2p2.samsung.com>
 <20230922113443.3297726-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922113443.3297726-1-jtp.park@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 08:34:43PM +0900, Jeongtae Park wrote:
> Changes since v1: [1]
> - Seperate a fix for whitespace error/warnings in memdev (Dave)
> - Drop a fix for a traceevent macro (Dave)
> - Add reviewed-by tags
> 
> [1]: https://lore.kernel.org/lkml/20230921025110.3717583-1-jtp.park@samsung.com/
> 
> ---
> Cover letter same as v1

None of these emails were properly threaded (look at lore.kernel.org for
proof.)

Please fix your email client to do this properly, your v1 of this series
was threaded correctly, so something changed here :(

thanks,

greg k-h
