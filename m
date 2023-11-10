Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613907E7F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjKJRzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjKJRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE33289D;
        Fri, 10 Nov 2023 04:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6EDC433C8;
        Fri, 10 Nov 2023 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699617950;
        bh=FANwVyHHNldSGNrf6smnb0g9+z/X47XttStGkOaEAyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLMpGod3aUldA/oNpy3DazniO6/HK2kkZkqO4tSS3O0hFl/UWrpwkqFC1RjRbev8l
         iKZNmJv1z7vyYcEghIHFlQK9KTJFg0SlKBkXYNeCKFHuDFv+NBAjLnHAfScEESUXxy
         MgB7aYkSSM92WAWw8yhspankNQyZ5QNUxaWPnxlJ7sQNqkT0+y6HHu5IDrk2EstkAw
         HM84Fv6nAZc74Hl7+p+CVeeh+chLcrmh2BZhdjsCntwHkDtkh02CPrIqfAhMWTJmTQ
         NhuzWLpMnFiZYe0kJ1UBLZgqmfgEBhJaWHeRUKFjPSlYpKVNArhsMscdA+Tct5qj6J
         mvuZPItx8+zmQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9CB2F40094; Fri, 10 Nov 2023 09:05:47 -0300 (-03)
Date:   Fri, 10 Nov 2023 09:05:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Mark Wielaard <mark@klomp.org>,
        Jason Merrill <jason@redhat.com>
Subject: Re: [RFC 00/52] perf tools: Introduce data type profiling (v2)
Message-ID: <ZU4cmwfQSK5wXbAD@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 09, 2023 at 03:59:19PM -0800, Namhyung Kim escreveu:
> * Patch structure
> 
> The patch 1-5 are cleanups and a fix that can be applied separately.

Applied so far 1-9, will continue later.

- Arnaldo
