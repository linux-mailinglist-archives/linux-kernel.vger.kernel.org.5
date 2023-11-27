Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4559F7FA92E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjK0Sod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0Soc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:44:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59B1A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:44:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C84C433C7;
        Mon, 27 Nov 2023 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701110678;
        bh=YX/z4BlRTU3n39F3XQDmoocqrUTZvvJZizRdM7PZwAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5GaAlfzCiqFGp7FWT1u0WNKsIFL4M4+STpbSk0vZnVAZ9/FC8f3YG8gl+GmSlWaS
         kuePSmdXlC6qbVfkD/nhF9oq3ESqqHeNHAnfgpbkbhMTFj3hEf6csEPGJ2BUfvITho
         99XJwZDi7rZhZ3mj+9q2/ZsFqf+mXZE6ZMWpdX+jkETGG/aHBHJ9N0Fk+NimZpHxv4
         ts3ROle+WHyvmU1VjDGghdXP8+esf4tln/GkODq7VB1Or86qbF9XE0W14G2C3zW3yK
         Wrkm+X9YeeeD68W2S7xC6JYrQqhxCFPkKD1KqvEZPTvf12jr90yyOPD8mXGGtS8dC0
         zMnYgU9wEmNfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7919B40094; Mon, 27 Nov 2023 15:44:35 -0300 (-03)
Date:   Mon, 27 Nov 2023 15:44:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v1] perf vendor events: Add skx, clx, icx and spr upi
 bandwidth metric
Message-ID: <ZWTjk7YdIsQkmJJ8@kernel.org>
References: <20231109232732.2973015-1-irogers@google.com>
 <CAP-5=fV50dXzK47WyqT-MEX1TfTrEJdGNhuBLSQ3nLE0+F3_Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV50dXzK47WyqT-MEX1TfTrEJdGNhuBLSQ3nLE0+F3_Uw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 27, 2023 at 10:17:48AM -0800, Ian Rogers escreveu:
> On Thu, Nov 9, 2023 at 3:28 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Add upi_data_receive_bw metric for skylakex, cascadelakex, icelakex
> > and sapphirerapids. The metric was added to perfmon metrics in:
> > https://github.com/intel/perfmon/pull/119
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

No Acked-by from Intel people, please consider providing it in the
future.

Thanks, applied.

- Arnaldo
