Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4C7E2F02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjKFVfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjKFVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:35:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDACCD7E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:35:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E7BC433C7;
        Mon,  6 Nov 2023 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699306527;
        bh=Zw3vYH8zoR3MlXxt86euMwdRDqQReCKtsJxBaa8jPdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/5n1TpkXFwoRTwjyDMA4LlTK6sN//jPm0Hr/O+sxbOoggda37Bs1iSWmZplXqLka
         ZPF1ymRDACy53RH3KPUlJxNq5Oo6UomU3syNYOOiW9aAGd9vNi+d1yy8RitiYLgP1G
         UxNLfxzy5045XFYBNXiICEpj/nbzBrMt+gCn8nOvujfIoj0w8a65atwk4n1fG7i9Q8
         biwoBjqlK9rcXwTwyIRY1WhNtDKg4nmwotaftM6Ty3NcJrQ9QlqgXfX5LKkSsJQG/C
         iuqk/9GB/9iqQ7hHt0xDZZq55Wo+jtwKxq+/1SO+fGDJ0yzfcTrIaZITTkOIoWns8n
         uaquuFjvtuqeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2304C4035D; Mon,  6 Nov 2023 18:35:25 -0300 (-03)
Date:   Mon, 6 Nov 2023 18:35:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>, colin.i.king@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] perf: fix spelling mistake "parametrized" ->
 "parameterized"
Message-ID: <ZUlcHUW3shZxtthz@kernel.org>
References: <20231003074911.220216-1-colin.i.king@gmail.com>
 <CAP-5=fXO6+Cgvo4BmC9fgL70FY+ciPjRVR5qghxYBR3VSB7WNQ@mail.gmail.com>
 <6929FC3F-06F4-45D1-96D4-0ABF86EA8698@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6929FC3F-06F4-45D1-96D4-0ABF86EA8698@linux.vnet.ibm.com>
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

Em Wed, Oct 04, 2023 at 01:43:28PM +0530, Athira Rajeev escreveu:
> > On 04-Oct-2023, at 6:37 AM, Ian Rogers <irogers@google.com> wrote:
> > On Tue, Oct 3, 2023 at 12:49 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >> There are spelling mistakes in comments and a pr_debug message. Fix them.
> >> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > + Athira Rajeev
> > Reviewed-by: Ian Rogers <irogers@google.com>
 
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linux.vnet.ibm.com>>


Thanks, applied.

- Arnaldo
