Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B867CB276
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjJPS0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPS0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:26:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59CCA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:26:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4A4C433C8;
        Mon, 16 Oct 2023 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697480780;
        bh=4QtD0+rLtxMS6U30O6ec7Ox44kseY4kSGF0z7NZ53XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ufl78Ecqmotfjh5acHuhamZFw9ydHrqbHUmCQT+Z2jsGFLPTD0K7kUUVJm6LIuL7B
         K61baQNTSCk3h+pxmocjQT21QHEiJp13ByRijMcnrX40jbtEjfF8COrDSWjIdZQJfj
         fdJcyoPUU37C818FG3xVlgjIqDBME8mOk2t+dVjw=
Date:   Mon, 16 Oct 2023 20:26:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
Subject: Re: [PATCH v8 2/3] greybus: Add BeaglePlay Linux Driver
Message-ID: <2023101618-concept-rarity-3e0f@gregkh>
References: <20231006041035.652841-1-ayushdevel1325@gmail.com>
 <20231006041035.652841-3-ayushdevel1325@gmail.com>
 <9affdae9-9e95-1f6c-5f18-845d5ffcbd71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9affdae9-9e95-1f6c-5f18-845d5ffcbd71@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 05:11:23PM +0530, Ayush Singh wrote:
> Hello everyone, I would like to get some feedback on the driver patch before
> submitting the new version of this patch series.

I don't want to review a version that I know you are going to resubmit,
as that would waste my time when I should be reviewing patches from
others that they think are complete.

So just update and resend the new series please, no need to ask.

thanks,

greg k-h
