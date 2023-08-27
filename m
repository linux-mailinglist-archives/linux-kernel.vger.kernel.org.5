Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B0789C89
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjH0JMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjH0JMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8EAD;
        Sun, 27 Aug 2023 02:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF7F561215;
        Sun, 27 Aug 2023 09:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6D1C433C9;
        Sun, 27 Aug 2023 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693127535;
        bh=HM3WKQ5OxVgWwzF+fZk+JF992E4jrGxxso+nB/vwuqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OozhuMfF38EE67aqxmVwTU4PcUlUc0k7CSkrneYxKL/Cd4QojwDuzanY4PtqeClxR
         eisLWxOHnsPqwhmmXs342jhVvTcZvbD0uCL1wvsQl+BsLkK2PTKGNoul7ANHpuobau
         hniYqPSMkuyCwOywF1fqjNbXhggZPOonp3snepkM=
Date:   Sun, 27 Aug 2023 11:12:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srish Srinivasan <ssrish@vmware.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        borrello@diag.uniroma1.it, peterz@infradead.org, pauld@redhat.com,
        rostedt@goodmis.org, sashal@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, akaher@vmware.com,
        vsirnapalli@vmware.com, amakhalov@vmware.com, tkundu@vmware.com,
        keerthanak@vmware.com, srinidhir@vmware.com,
        kashwindayan@vmware.com, vbrahmajosyula@vmware.com
Subject: Re: [PATCH v4.19.y] sched/rt: pick_next_rt_entity(): check list_entry
Message-ID: <2023082757-granny-dilute-b0d3@gregkh>
References: <20230826021535.9065-1-ssrish@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826021535.9065-1-ssrish@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 07:45:35AM +0530, Srish Srinivasan wrote:
> From: Pietro Borrello <borrello@diag.uniroma1.it>
> 
> commit 7c4a5b89a0b5a57a64b601775b296abf77a9fe97 upstream.

Now queued up, thanks.

greg k-h
