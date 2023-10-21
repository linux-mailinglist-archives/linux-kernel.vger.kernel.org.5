Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42537D1E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjJURUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJURUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:20:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F4124
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:20:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FEAC433C7;
        Sat, 21 Oct 2023 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697908812;
        bh=LHTo6dE2gzrk+w9F4L6E3ao4k14+KnWLFi1dkALMavo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuXX9R9YWnZSSQnBi57sfXJlBmfvOl109UqRj1f8fNEOEKad3QwrRad3f4ANqnaw1
         FABB/+NMtT6fkd9pk7N95+p9ufHcx8bm9Qj9Cty5g1kxoLRIZb5bRXekJabb6lt13R
         p0fltafxZyWBQZcxRE9XTAGpWzB2KLqKk+8ZgBdo=
Date:   Sat, 21 Oct 2023 19:20:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] nvmem: patches for v6.7
Message-ID: <2023102150-dart-bogged-7431@gregkh>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:55:39AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Hi Greg,
> 
> Here are some nvmem patches
> - mostly around deprecating old style bindings.
> - make qfprom clks optional.
> - making use of device_get_match_data()
> 
> Can you please queue them up for 6.7

I took all but patch 4 for now.

thanks,

greg k-h
