Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5A7A02F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjINLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjINLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:45:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5B1FDF;
        Thu, 14 Sep 2023 04:45:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0CBC433CA;
        Thu, 14 Sep 2023 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694691917;
        bh=yax2Zuc41ijShkhRe4LFgT9nh3EzKnSmpf0Bh28oJqc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GEnfa9SErd5ufkKuswC61TVn14kBLqDi+N9x+Oo83nCnvP+pP4XX7JSaN5zdr/d0W
         oCWe6lunODuqdigJXwwalhoEmDVlSJilS5qI/UuLutgoEBLT166I2xxmm38EX62h5L
         fN4qyu7Gx/AhI+i/zUuT+YzU/VynqJsvgqOYQ9m07Xz7gsWGFaDIhHIc1lJMFYAjpd
         k8tFwaz2rog4PupAjiQ1iesq7u8/VEdr0OvyFE9UEqX9Fpe0sVbVlH+Jr82DkLSLyw
         K/O2PKkqXI7rnxwB2pa4lohEYUhlXtjdOYhJC8kqevNP0Hrw3ZkruIDzYP3oMph5xe
         Fc3kbjjRy6t+w==
Message-ID: <12024ae6-e4f9-b658-76cb-b0a8ff5bca1d@kernel.org>
Date:   Thu, 14 Sep 2023 13:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] verification/dot2k: Delete duplicate imports
To:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230906155703.3917918-1-alessandro.carminati@gmail.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230906155703.3917918-1-alessandro.carminati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 17:57, Alessandro Carminati (Red Hat) wrote:
> The presence of duplicate import lines appears to be a typo.
> Removing them.
> 
> Fixes: 24bce201d798 ("tools/rv: Add dot2k")
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>

Queued, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git/commit/?h=tools/verification&id=5a9587fea055163026b6d22d593fc64ed04de3a6

-- Daniel

