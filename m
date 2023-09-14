Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9097A0FED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjINVfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:35:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F93D2705;
        Thu, 14 Sep 2023 14:35:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081F1C433C8;
        Thu, 14 Sep 2023 21:35:14 +0000 (UTC)
Message-ID: <5ea7a8c9-5157-436a-9e31-351292c41328@xs4all.nl>
Date:   Thu, 14 Sep 2023 23:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Signed-off-by missing for commit in the v4l-dvb-fixes
 tree
Content-Language: en-US, nl
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230915072137.47cef093@canb.auug.org.au>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230915072137.47cef093@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 23:21, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   5503b2f2a9fa ("media: ivsc: Depend on VIDEO_DEV")
> 
> is missing a Signed-off-by from its committer.
> 

Fixed.

	Hans
