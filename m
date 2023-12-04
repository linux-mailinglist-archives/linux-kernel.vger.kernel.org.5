Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED9803F45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjLDU0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:26:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BF3CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:26:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0148C433C8;
        Mon,  4 Dec 2023 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701721616;
        bh=RUO62ldlZP9KwcJkqHitPPpiIOKUfgLfjbgl9wbMzt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cm/lro3C7SY1VPYFSZdmuAcF+uD8KD67JAkfVwzU7f4Nzl2k25dcxMRuiWRbH2rBN
         Ega4ZyU57dzxqlZaUYriDX9Rme7xQRC8CWpKxI4deN+vMqugHFlNIW7g/9YIrmUyNu
         do+s48CZDH6GrmPh2DDyFvgqLZdhuWs5eCVtqptUmFvNpl8wGzf/FuW36TXdiALFPh
         lLD+p7Pr1TxfTQOvsyamZwelFypDacaoXRmLqtQmAB2VhqbjuHfgTPKkhD50GZVgGr
         lV77uYhcDRJk0HxJ5k+wbXVUcH3fUGZaSXYKu5O8ZRxkEOLhKm65+UwJHId4qUgziB
         HSLl6pFGgf3OQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8FEA040094; Mon,  4 Dec 2023 17:26:54 -0300 (-03)
Date:   Mon, 4 Dec 2023 17:26:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf/benchmark: Fix spelling mistake
 "synchronious" -> "synchronous"
Message-ID: <ZW42Du8dtF2b2zHJ@kernel.org>
References: <20230630080029.15614-1-colin.i.king@gmail.com>
 <CAP-5=fUX_ktsmrrVGr9kwa3-C_4=yobTFgm5L+TpFNt8UZMZGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUX_ktsmrrVGr9kwa3-C_4=yobTFgm5L+TpFNt8UZMZGg@mail.gmail.com>
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

Em Fri, Jun 30, 2023 at 08:18:49AM -0700, Ian Rogers escreveu:
> On Fri, Jun 30, 2023 at 1:00 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There is a spelling mistake in an option description. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

