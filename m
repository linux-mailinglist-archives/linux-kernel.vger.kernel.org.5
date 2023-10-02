Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284E7B55D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbjJBOmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjJBOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:42:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1F0F9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:42:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC76BC433CC;
        Mon,  2 Oct 2023 14:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696257726;
        bh=ZPe4pSy+Dt4W9BX0d9+pzF4Ly6fqblPVquBnBAbO524=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHhYOolhqLdXf0jtTHPQXEYzzhmnRPr7W+48/8qX13OobehhBwF+AlEjuZOeS4A5w
         cZIQ8ngKIbTrMQcsAi3R1xOkwp9ycYiuoSeNcGBh7vW+XAbil3ICr4LfE6xRSlV4Tp
         M300cT2+RItXN3YzP/ymZrpEp7jM84D7cgNEidAs=
Date:   Mon, 2 Oct 2023 16:42:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc:     Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] usb: fix kernel-doc warning
Message-ID: <2023100253-aide-authentic-5aa1@gregkh>
References: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:05:05AM +0530, Swarup Laxman Kotiaklapudi wrote:
> Fix kernel-doc warnings discovered in usb driver.
> Fixes this warning:
> warning: Function parameter or member 'gfladj_refclk_lpm_sel'
>          not described in 'dwc3'
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> ---
>  drivers/usb/dwc3/core.h | 2 ++
>  1 file changed, 2 insertions(+)

What commit id does this fix?

thanks,

greg k-h
