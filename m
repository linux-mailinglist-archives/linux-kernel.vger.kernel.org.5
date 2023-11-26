Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2567F9234
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjKZKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKZKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:30:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86456FD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:30:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABA2C433C7;
        Sun, 26 Nov 2023 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700994628;
        bh=jBYZySQmXXp7GkW2G6nnviQuF9V1/gxHhjXx0DeK0SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldeDO7edZmsVA5Y4AerlWeeMy4DzbaV8PStYdQrcPrpbp0zKNKIG40qbe6codZSql
         D+xvj52x0zz0WSFFcWh/62OGhtPLyRG2NgsP6b1YV92Y17/7Mv++SUW4bnAQvpTIND
         CAPlohUpSzeMlkGmZJxqaK8/jn1i+shTZ2SZPJDA=
Date:   Sun, 26 Nov 2023 10:30:25 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8192e: renamed 2 variables nMcsRate,
 mcsRate
Message-ID: <2023112616-scallop-drier-ab16@gregkh>
References: <20231125223432.13780-1-garyrookard@fastmail.org>
 <20231125223432.13780-2-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125223432.13780-2-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 05:34:28PM -0500, Gary Rookard wrote:
> Renamed 2 variables from CamelCase to Snake case nMcsRate
> and mcsRate.
> nMcsRate -> n_mcs_rate

Please drop the "n".

thanks,

greg k-h
