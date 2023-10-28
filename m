Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701CA7DA965
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjJ1VKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjJ1VKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:10:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBAD3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 14:10:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212DDC433C8;
        Sat, 28 Oct 2023 21:10:02 +0000 (UTC)
Date:   Sat, 28 Oct 2023 17:09:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Tom Zanussi <zanussi@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel/trace/trace_kprobe.c:952: warning: Excess function
 parameter 'args' description in '__kprobe_event_gen_cmd_start'
Message-ID: <20231028170959.39ae1ea2@rorschach.local.home>
In-Reply-To: <ZTtIWZ/Ol3SuirV8@yujie-X299>
References: <202310190437.paI6LYJF-lkp@intel.com>
        <20231019092207.7d2fa545@gandalf.local.home>
        <ZTtIWZ/Ol3SuirV8@yujie-X299>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 13:19:21 +0800
Yujie Liu <yujie.liu@intel.com> wrote:
> 
> Hi Steven, the fix patch is sent at [1] to fix this kernel-doc warning.
> 
> [1] https://lore.kernel.org/all/20231027041315.2613166-1-yujie.liu@intel.com/
> 

Masami is now co-maintainer of the tracing subsystem and handles the
probes side of things. Looks like he's picking it up.

Thanks,

-- Steve

