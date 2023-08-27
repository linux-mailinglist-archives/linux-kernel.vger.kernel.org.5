Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4559878A11B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjH0S71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjH0S7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C38F5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 11:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31D5D62409
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 18:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBEFC433C7;
        Sun, 27 Aug 2023 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693162749;
        bh=LFN9pzEVJKFSnFAxp0SrtncRVOxG9YJ2haP9S/9DE2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMpAGL8PR0QwicuqniGxpkbdQhZrYgGn0cGGe1CxbiLeuA6NjQnIk0xBuXKgKv8R0
         lfDknvWEF0zc3OscKcFvWxcs6P5IwIAnSs2wZA6NG3M3vCfLGmWXucsgAG5SFxDTSv
         +xhVQ01ZddKxiZwH4jpAfPrqtuvdCgnSzFAvwPG4=
Date:   Sun, 27 Aug 2023 20:59:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ozlinux@hotmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: clean up octeon ethernet driver
Message-ID: <2023082747-tinsmith-captivate-fd91@gregkh>
References: <PH7PR11MB7643572E8C1231C013762613BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <2023082744-alike-spendable-5b87@gregkh>
 <PH7PR11MB76437D43414E0D5F2D579219BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB76437D43414E0D5F2D579219BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 01:59:00PM -0400, ozlinux@hotmail.com wrote:
> I was wondering what your patch bot meant about #1. How would I go about
> splitting this patch up to make it more readable?

One logical change at a time please.

thanks,

greg k-h
