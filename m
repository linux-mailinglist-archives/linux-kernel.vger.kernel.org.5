Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0B97E1CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjKFJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKFJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE53DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:00:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660E1C433C7;
        Mon,  6 Nov 2023 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699261216;
        bh=mzmV/kUvsNNTyveHw/q1AZEZsm1BXGjVO0cnJmmbZBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kn2B1skeYfzHsymog73l1XXcBKDySkeTf+fkA/pWzunobHp0tCmgUfP+Cri3wixju
         hsfNF0GtvBsdNq7iU0gIgdUwgObgmzsGaeT0iu+aGre/9zE7AY1t0IqGTPmtGqZdmq
         2ge5jHQ81RjHpCq8fWaGMYmZTghoxwXsLZEepE20=
Date:   Mon, 6 Nov 2023 10:00:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning:
 'range_ni_E_ao_ext' defined but not used
Message-ID: <2023110641-profusely-factor-b3c5@gregkh>
References: <202311060001.aEuf1q9y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311060001.aEuf1q9y-lkp@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 04:49:17PM +0800, kernel test robot wrote:
> Hi Greg,
> 
> kernel test robot noticed the following build warnings:
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
> commit: 8ffdff6a8cfbdc174a3a390b6f825a277b5bb895 staging: comedi: move out of staging directory
> date:   2 years, 7 months ago

Have you tested a newer kernel?  Testing a 2 1/2 year old commit feels
odd to me, was this intentional?

thanks,

greg k-h
