Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA87D9422
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJ0Js2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0Js1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:48:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA19D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:48:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BDCC433C7;
        Fri, 27 Oct 2023 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698400104;
        bh=MH469qV0l5yqT7LwQg1gg4EN+tSFNf3rOq8UFVExNCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIuuA0bTNCzZk6zvGKXhLEoM1cT8sGF9ek4Ked198WkcdeogxuepFPCWyLRhvXj5D
         VOmEcev0SmKXZUiC/Wwyg5a2OBYu7L5yHpEeI7/F+lIK71C0TDsQ8Dbb2AeP2IyrV/
         6xpnfaszupofvxLuGD9R7VlrM4/U+7FJhOXx6PsA=
Date:   Fri, 27 Oct 2023 11:40:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for 6.7
Message-ID: <2023102736-darkening-confider-29b0@gregkh>
References: <461139be-c11a-41c4-b09a-f8f1b7c61ec0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461139be-c11a-41c4-b09a-f8f1b7c61ec0@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:20:09PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.7. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:
> 
>   Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.7

Pulled and pushed out, thanks.

greg k-h
