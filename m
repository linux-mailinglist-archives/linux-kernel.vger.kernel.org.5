Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0577D1378
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377871AbjJTQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377861AbjJTQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:02:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A7112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:02:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BFDC433C9;
        Fri, 20 Oct 2023 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697817732;
        bh=WefkTqJBqzx7ciMu7quS5jTwqdF/GzGrpsyn7JxjXCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAnJT4E1xLbKDKqYfCTV2Poz/bylMunLLHsqVTzXt9Jandj/BAbqBRoNOFFRgjEK/
         JbD/o+7rtDvp7Lx4xOOL+fVn1FR1XpxkaH2hocXerup2Vt4iUzFU4bxyhZT012KWyP
         MVqAEMWAsvCLC7/EeNPRlTgiIORxzJAsYtS36IdE=
Date:   Fri, 20 Oct 2023 18:02:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Shuo <1289151713@qq.com>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: camera: fixes alignment should match
 open parenthesis
Message-ID: <2023102039-smoking-dirtiness-14c0@gregkh>
References: <tencent_2E5278ECD059882823EF2A5209D98B53E306@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2E5278ECD059882823EF2A5209D98B53E306@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:12:03PM +0800, Chen Shuo wrote:
> This patch fixes the checks reported by checkpatch.pl
> for alignment should match open parenthesis

No it does not, sorry.

Also, any reaason you did not also cc: the proper maintainers as
scripts/get_maintainer.pl told you to?

thanks,

greg k-h
