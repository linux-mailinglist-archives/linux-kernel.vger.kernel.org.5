Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19C37F9233
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKZK3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:29:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70863FD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:29:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A87C433C7;
        Sun, 26 Nov 2023 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700994595;
        bh=76Fk0DLzKgmqcjG7nPYWawqfhDzTfjUtNJQgpxhd74w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HX8PoIbVw5umcqY4/1z60IIL2oeh6yK5Z/CsImpgOCbq8fm9ncYTGWW2BFEJj7gBD
         cUNQ6tvZE7WqE08mcSZgViFLLFPdEDhGf83T8yxfIqmEzOXJMt1BpVoCDIZENA0Lk2
         QcHHGzUHDoDYawmzSmbAgSSBxTAmLP3tu9A3xTjo=
Date:   Sun, 26 Nov 2023 10:29:52 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: rtl8192e: renamed variable bCurBW40MHz
Message-ID: <2023112618-subdued-genetics-8062@gregkh>
References: <20231125223432.13780-1-garyrookard@fastmail.org>
 <20231125223432.13780-4-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125223432.13780-4-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 05:34:30PM -0500, Gary Rookard wrote:
> Renamed from CamelCase to Snake case the variable bCurBW40MHz.
> bCurBW40MHz -> b_cur_bw_40mhz

Same here, why keep the "b"?  "b" usually means "byte" which of course
means nothing here, so it can be dropped.

thanks,

greg k-h
